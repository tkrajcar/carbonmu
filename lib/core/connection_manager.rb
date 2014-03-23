
module CarbonMU
  module ConnectionManager
    @@connections = []

    def self.add(c)
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
