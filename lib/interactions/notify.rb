module CarbonMU
  class Notify
    def self.all(text)
      CarbonMU.server.write_to_all_connections(text + "\n")
    end

    def self.one(connection_id, text)
      CarbonMU.server.write_to_connection(connection_id, text + "\n")
    end
  end
end
