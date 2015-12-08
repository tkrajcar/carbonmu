module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      response_raw "PONG"
    end
  end
end
