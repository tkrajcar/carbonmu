module CarbonMU
  class UnknownCommand < Command
    def execute
      @player.notify_raw "Unknown command: #{@raw_command}"
    end
  end
end
