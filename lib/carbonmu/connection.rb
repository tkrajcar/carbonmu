module CarbonMU
  class Connection
    attr_reader :id
    attr_accessor :player

    # TODO probably need edge type (:telnet, :ssl, etc), or at least interactive true/false
    def initialize(id)
      @id = id
      @player = nil
    end

    def write_translated(msg, args = {})
      CarbonMU.server.write_to_connection(id, msg, args)
    end

    def write_raw(msg)
      CarbonMU.server.write_to_connection_raw(id, msg)
    end

    def quit
      CarbonMU.server.close_connection(self.id)
    end

    alias_method :write, :write_translated
  end
end
