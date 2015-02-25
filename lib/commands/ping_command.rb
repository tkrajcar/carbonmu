module CarbonMU
  class PingCommand
    c = Command.new(prefix: :ping) do
      Notify.one(enacting_connection_id, "PONG")
    end
    CommandManager.add(c)
  end
end
