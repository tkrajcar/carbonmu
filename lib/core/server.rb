module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger

    def initialize
      info "*** Starting CarbonMU game server."
      # TODO talk to Overlord to retrieve any already-open connections.
    end

    def add_connection(connection)
      ConnectionManager.add(connection)
    end

    def remove_connection(connection)
      ConnectionManager.remove(connection)
    end

    def connections
      ConnectionManager.connections
    end

    def handle_input(input, connection)
      context = CommandContext.new(connection)
      Parser.parse(input, context)
    end
  end
end
