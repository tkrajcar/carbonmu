require 'celluloid/io'
require 'celluloid/zmq'
require 'multi_json'

module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    attr_reader :zmq_context, :zmq_out, :zmq_in

    finalizer :shutdown

    def initialize(socket_out = nil, socket_in = nil)
      info "*** Starting CarbonMU game server."

      if socket_out.nil?
        @zmq_out = PushSocket.new
        @zmq_out.bind("tcp://127.0.0.1:15001")
      else
        @zmq_out = socket_out
      end

      if socket_in.nil?
        @zmq_in = PullSocket.new
        @zmq_in.connect("tcp://127.0.0.1:15000")
      else
        @zmq_in = socket_in
      end

      async.run
      retrieve_existing_connections
    end

    def run
      loop do
        async.handle_overlord_datagram(@zmq_in.read)
      end
    end

    def shutdown
      error "Terminating server!"
      @zmq_sub.close if @zmq_sub
      @zmq_pub.close if @zmq_pub
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
      puts "Connection is #{context.enacting_connection}"
      Parser.parse(context)
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
      @zmq_out.send datagram
    end
  end
end
