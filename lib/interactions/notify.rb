module CarbonMU
  class Notify
    def self.all(text)
      ConnectionManager.connections.each do |c|
        c.write(text)
      end
    end

    def self.one(connection, text)
      connection.write(text)
    end
  end
end
