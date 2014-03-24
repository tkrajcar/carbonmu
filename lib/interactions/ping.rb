module CarbonMU
  class Ping
    def self.ping
      Notify.all("Pinging...!")
      Server.ping
    end
  end
end
