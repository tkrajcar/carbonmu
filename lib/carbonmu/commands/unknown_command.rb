module CarbonMU
  class UnknownCommand < Command
    def execute
      @context.player.notify_raw "Unknown command: #{@context.raw_command}"
    end
  end
end
