module CarbonMU
  class PingCommand < Command
    command do
      Notify.one(enacting_connection, "PONG")
    end
  end
end
