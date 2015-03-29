module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      @context.enactor.notify_raw "PONG"
    end
  end
end
