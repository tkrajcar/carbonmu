require 'celluloid/io'
require 'celluloid/zmq'
require "mongoid"
require "colorize"
require "core_ext/string"
require "carbonmu/internationalization"
require "carbonmu/game_object"
require "carbonmu/parser"
require "carbonmu/ipc/ipc_message"
require "carbonmu/connection"

Dir[File.dirname(__FILE__) + '/game_objects/*.rb'].each {|file| require file }

module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    finalizer :shutdown

    attr_reader :connections, :parser

    def initialize(standalone = false)
      Internationalization.setup

      info "*** Starting CarbonMU game server to connect to edge router port #{CarbonMU.edge_router_receive_port}."
      CarbonMU.server = Actor.current

      @parser = Parser.new

      Server.initialize_database
      Server.create_starter_objects

      unless standalone
        @ipc_reader = ReadSocket.new
        @ipc_writer = WriteSocket.new(CarbonMU.edge_router_receive_port)
        send_server_started_to_edge_router

        async.run

        retrieve_existing_connections
      end
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
      c = Connection.new(connection_id)
      c.player = Player.superadmin #TODO real login
      @connections << c
    end

    def remove_connection(connection_id)
      @connections.delete_if { |c| c.id == connection_id }
    end

    def handle_command(input, connection_id)
      connection = @connections.find { |c| c.id == connection_id }
      @parser.parse_and_execute(connection, input)
    end

    def write_to_connection(connection_id, str)
      send_message_to_edge_router(:write, connection_id: connection_id, output: str)
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

    def send_message_to_edge_router(op, params={})
      message = IPCMessage.new(op, params)
      debug "SERVER SEND: #{message}" if CarbonMU.configuration.log_ipc_traffic
      @ipc_writer.send message.serialize
    end

    def self.initialize_database
      Mongoid.logger.level = ::Logger::DEBUG
      Mongoid.load!("config/database.yml", ENV["MONGOID_ENV"] || :production)
      ::Mongoid::Tasks::Database.create_indexes
    end

    def self.create_starter_objects
      ensure_special_exists(:starting_room, Room, {name: "Starting Room", description: "This is the starting room for newly-created players. Feel free to rename and re-describe it."})
      ensure_special_exists(:lostandfound_room, Room, {name: "Lost & Found Room", description: "This is the room where objects and players go if the thing that was holding them gets destroyed."})
      ensure_special_exists(:superadmin_player, Player, {name: "Superadmin", description: "Obviously the most powerful of his race, it could kill us all."})
    end

    def self.ensure_special_exists(special, klass, attributes)
      klass.create!(attributes.merge(_special: special)) if klass.where(_special: special).count == 0
    end
  end
end
