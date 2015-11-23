require "mongoid"
require "colorize"
require "core_ext/string"
require "carbonmu/internationalization"
require "carbonmu/game_object"
require "carbonmu/parser"

Dir[File.dirname(__FILE__) + '/game_objects/*.rb'].each {|file| require file }

module CarbonMU
  class Server
    include Celluloid
    include Celluloid::Logger

    finalizer :shutdown

    attr_reader :parser

    def initialize(standalone = false)
      Internationalization.setup

      info "*** Starting CarbonMU game server."

      @parser = Parser.new

      Server.initialize_database
      Server.create_starter_objects
    end

    def shutdown
      error "Terminating server!"
    end

    def handle_command(input, connection)
      @parser.parse_and_execute(connection, input)
    end

    def self.trigger_reboot
      Actor[:server].send_reboot_message_to_edge_router
    end

    def send_reboot_message_to_edge_router
      send_message_to_edge_router(:reboot)
    end

    def players
      connections.collect(&:player).uniq
    end

    def write_to_connection_raw(connection, message)
      edge_router.write(connection.id, message)
    end

    def close_connection(connection_id)
      edge_router.remove_connection(connection_id)
    end

    def notify_all_players(message, args = {})
      players.each { |p| notify_player(p, message, args) }
    end

    def notify_all_players_raw(message)
      players.each { |p| notify_player_raw(p, message) }
    end

    def notify_player(player, message, args = {})
      notify_player_raw(player, player.translate_message(message, args))
    end

    def notify_player_raw(player, message)
      debug "Notifying player #{player} with #{message}"
      connections_for_player(player).each { |c| write_to_connection_raw(c, message)}
    end

    def connections_for_player(player)
      connections.select { |c| c.player == player }
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
