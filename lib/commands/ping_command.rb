module CarbonMU
  class PingCommand
    c = Command.new(prefix: :ping) do
      Notify.one(enacting_connection, "PONG")
    end
    CommandManager.add(c)
  end
end
