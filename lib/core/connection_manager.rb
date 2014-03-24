
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

    def self.remove_by_id(id)
      @@connections.delete_if { |x| x.id == id}
    end

    def self.connections
      @@connections
    end
  end
end