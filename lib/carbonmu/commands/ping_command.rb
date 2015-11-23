module CarbonMU
  class PingCommand < Command
    syntax "ping"

    def execute
      @connection.write "PONG"
    end
  end
end
