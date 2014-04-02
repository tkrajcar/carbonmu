module CarbonMU
  class PingCommand
    CommandManager.add :ping do
      Notify.one(enacting_connection, "PONG")
    end
  end
end
