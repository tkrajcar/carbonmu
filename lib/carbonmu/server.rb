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
  end
end
