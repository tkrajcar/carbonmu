module CarbonMU
  class Notify
    def self.all(text)
      ConnectionManager.connections.each do |c|
        c.write(text)
      end
    end
  end
end
