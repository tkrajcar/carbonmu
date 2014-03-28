require 'celluloid/io'
require 'celluloid/zmq'
require 'multi_json'

module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    finalizer :shutdown

    def initialize
      info "*** Starting CarbonMU game server to connect to overlord port #{CarbonMU.overlord_receive_port}."

      @ipc_reader = ReadSocket.new
      @ipc_writer = WriteSocket.new(CarbonMU.overlord_receive_port)
      send_server_started_to_overlord

      EmbeddedDataEngine.supervise_as :data_engine
      Actor[:data_engine].load_all

      async.run
      retrieve_existing_connections
    end

    def run
      loop do
        async.handle_overlord_datagram(@ipc_reader.read)
      end
    end

    def shutdown
      error "Terminating server!"
    end

    def add_connection(connection_id)
      new_conn = ServerConnection.new(connection_id, Actor.current)
      ConnectionManager.add(new_conn)
    end

    def remove_connection(connection_id)
      ConnectionManager.remove_by_id(connection_id)
    end

    def connections
      ConnectionManager.connections
    end

    def handle_command(input, connection_id)
      context = CommandContext.new(enacting_connection: ConnectionManager[connection_id], command: input)
      Parser.parse(context)
    end

    def send_server_started_to_overlord
      send_hash_to_overlord({op: "started", port: @ipc_reader.port_number, pid: Process.pid})
    end

    def handle_overlord_datagram(input)
      parsed = MultiJson.load(input)
      info "SERVER RECEIVE: #{parsed}"
      case parsed['op']
      when 'cmd'
        handle_command(parsed['cmd'], parsed['connection_id'])
      when 'connect'
        add_connection(parsed['connection_id'])
      when 'disconnect'
        remove_connection(parsed['connection_id'])
      else
        raise ArgumentError, "Unsupported operation '#{parsed['op']}' received from Overlord."
      end
    end

    def retrieve_existing_connections
      send_hash_to_overlord({op: "retrieve_existing_connections"})
    end

    def self.trigger_reboot
      Actor[:server].send_reboot_message_to_overlord
    end

    def send_reboot_message_to_overlord
      send_hash_to_overlord({op: "reboot"})
    end

    def write_to_connection(connection_id, str)
      datagram = {op: "write", connection_id: connection_id, output: str}
      send_hash_to_overlord(datagram)
    end

    def send_hash_to_overlord(hash)
      datagram = MultiJson.dump(hash)
      info "SERVER SEND: #{datagram}"
      @ipc_writer.send datagram
    end
  end
end
