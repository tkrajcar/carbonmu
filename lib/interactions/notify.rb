module CarbonMU
  class Notify
    def self.all(text)
      ConnectionManager.connections.each do |c|
        c.write(text)
      end
    end

    def self.one(connection_id, text)
      conn = ConnectionManager.connections.select { |x| x.id == connection_id}.first # todo replace with betterness.
      conn.write(text)
    end
  end
end
