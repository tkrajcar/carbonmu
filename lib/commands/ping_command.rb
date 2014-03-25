module CarbonMU
  class PingCommand < Command
    command do
      Notify.one(enacting_connection_id, "PONG")
    end
  end
end
