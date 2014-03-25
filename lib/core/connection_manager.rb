module CarbonMU
  module ConnectionManager
    @@connections = {}

    def self.[](x)
      @@connections[x]
    end

    def self.add(c)
      @@connections[c.id] = c
    end

    def self.remove(c)
      remove_by_id(c.id)
    end

    def self.remove_by_id(id)
      @@connections.delete(id)
    end

    def self.remove_all
      @@connections = {}
    end

    def self.connections
      @@connections.values
    end
  end
end