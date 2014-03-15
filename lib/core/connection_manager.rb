
module CarbonMU
  class ConnectionManager
    @@connections = []

    def self.add(socket)
      c = Connection.new(socket)
      @@connections << c
      c
    end

    def self.remove(c)
      @@connections.delete(c)
    end

    def self.connections
      @@connections
    end
  end
end
