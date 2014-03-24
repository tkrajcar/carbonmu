module CarbonMU
  class ServerConnection
    attr_reader :id, :server

    def initialize(id, server)
      @id = id
      @server = server
    end

    def write(str)
      @server.write_to_connection(id, str)
    end
  end
end