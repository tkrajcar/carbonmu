module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      @context.player.notify_raw "PONG"
    end
  end
end
