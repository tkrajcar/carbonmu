module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      Notify.one(@context.enacting_connection, "PONG")
    end
  end
end
