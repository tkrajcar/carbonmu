module CarbonMU
  class PingCommand < Command
    command do
      Ping.ping
    end
  end
end
