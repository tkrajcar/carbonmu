module CarbonMU
  class ExitCommand < Command
    syntax "exit"
    syntax "quit"

    def execute
      @context.connection.quit
    end
  end
end
