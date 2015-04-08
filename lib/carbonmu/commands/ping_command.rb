module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      @player.notify_raw "PONG"
    end
  end
end
