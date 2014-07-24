module CarbonMU
  class Notify
    def self.all(text)
      ConnectionManager.connections.each do |c|
        c.write(text + "\n")
      end
    end

    def self.one(connection, text)
      connection.write(text + "\n")
    end
  end
end
