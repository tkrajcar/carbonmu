module CarbonMU
  class UnknownCommand < Command
    def execute
      Notify.one(@context.enacting_connection_id, "Unknown command: #{@context.raw_command}")
    end
  end
end
