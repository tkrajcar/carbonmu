module CarbonMU
  class UnknownCommand < Command
    def execute
      @connection.write "Unknown command: #{@raw_command}"
    end
  end
end
