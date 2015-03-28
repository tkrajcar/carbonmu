module CarbonMU
  class Notify
    def self.all(text, opts = {})
      CarbonMU.server.connections.each { |c| one(c, text, opts) }
    end

    def self.one(connection, text, opts = {})
      connection.write_translated(text, opts)
    end
  end
end
