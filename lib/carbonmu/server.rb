require "colorize"
require "core_ext/string"
require "carbonmu/database"
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
      @database = Database.new
      @database.ensure_starter_objects
      @database.ensure_indexes
    end

    def shutdown
      error "Terminating server!"
    end

    def handle_interactive_command(input, connection)
      begin
        @parser.parse_and_execute(connection, input)
      rescue Exception => e
        connection.write("Sorry, your command caused a server problem and couldn't be executed.")
        error "Unhandled Exception in Server: #{e.class} #{e.message}"
        error e.backtrace.join("\n")
      end
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
  end
end
