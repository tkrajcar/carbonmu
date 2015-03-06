module CarbonMU
  class Connection
    attr_reader :id
    attr_accessor :locale
    # TODO probably need edge type (:telnet, :ssl, etc), or at least interactive true/false
    def initialize(id)
      @id = id
      @locale = "en" # TODO configurable default locale
    end

    def write(msg)
      CarbonMU.server.write_to_connection(id, msg + "\n")
    end
  end
end
