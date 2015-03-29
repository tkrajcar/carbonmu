module CarbonMU
  class UnknownCommand < Command
    def execute
      @context.enactor.notify_raw "Unknown command: #{@context.raw_command}"
    end
  end
end
