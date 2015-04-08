module CarbonMU
  class ExitCommand < Command
    syntax "exit"
    syntax "quit"

    def execute
      @connection.quit
    end
  end
end
