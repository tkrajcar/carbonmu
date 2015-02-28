require 'celluloid/io'
require 'celluloid/zmq'
require 'mongoid'

module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    finalizer :shutdown

    attr_reader :connections

    def initialize
      info "*** Starting CarbonMU game server to connect to edge router port #{CarbonMU.edge_router_receive_port}."
      CarbonMU.server = Actor.current

      @ipc_reader = ReadSocket.new
      @ipc_writer = WriteSocket.new(CarbonMU.edge_router_receive_port)
      send_server_started_to_edge_router

      Server.initialize_database

      async.run
      retrieve_existing_connections
    end

    def run
      loop do
        async.handle_edge_router_message(@ipc_reader.read)
      end
    end

    def shutdown
      error "Terminating server!"
    end

    def add_connection(connection_id)
      @connections ||= []
      @connections << connection_id
    end

    def remove_connection(connection_id)
      @connections.delete(connection_id)
    end

    def handle_command(input, connection_id)
      Parser.parse_and_execute(connection_id, input)
    end

    def send_server_started_to_edge_router
      send_message_to_edge_router(:started, port: @ipc_reader.port_number, pid: Process.pid)
    end

    def handle_edge_router_message(input)
      message = IPCMessage.unserialize(input)
      debug "SERVER RECEIVE: #{message}" if CarbonMU.configuration.log_ipc_traffic
      case message.op
      when :command
        handle_command(message.command, message.connection_id)
      when :connect
        add_connection(message.connection_id)
      when :disconnect
        remove_connection(message.connection_id)
      else
        raise ArgumentError, "Unsupported operation '#{message.op}' received from edge router."
      end
    end

    def retrieve_existing_connections
      send_message_to_edge_router(:retrieve_existing_connections)
    end

    def self.trigger_reboot
      Actor[:server].send_reboot_message_to_edge_router
    end

    def send_reboot_message_to_edge_router
      send_message_to_edge_router(:reboot)
    end

    def write_to_all_connections(str)
      connections.each {|c| write_to_connection(c, str) }
    end

    def write_to_connection(connection_id, str)
      send_message_to_edge_router(:write, connection_id: connection_id, output: str)
    end

    def send_message_to_edge_router(op, params={})
      message = IPCMessage.new(op, params)
      debug "SERVER SEND: #{message}" if CarbonMU.configuration.log_ipc_traffic
      @ipc_writer.send message.serialize
    end

    def self.initialize_database
      Mongoid.logger.level = ::Logger::DEBUG
      Mongoid.load!("mongoid.yml", :production)
      ::Mongoid::Tasks::Database.create_indexes
    end

  end
end
