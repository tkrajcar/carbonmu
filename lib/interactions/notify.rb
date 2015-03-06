module CarbonMU
  class Notify
    def self.all(text)
      CarbonMU.server.connections.each { |c| one(c, text) }
    end

    def self.one(connection, text)
      connection.write(text + "\n")
    end
  end
end
