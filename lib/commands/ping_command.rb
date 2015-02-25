module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      Notify.one(@context.enacting_connection_id, "PONG")
    end
  end
end
