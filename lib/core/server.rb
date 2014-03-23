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

    def self.reboot
      Actor[:overlord].reboot_server
    end

    def reboot_signal
      raise Error, "Rebooting... " # TODO replace this and all overlord<>server comms with real IPC so that code gets autoloaded.
    end
  end
end
