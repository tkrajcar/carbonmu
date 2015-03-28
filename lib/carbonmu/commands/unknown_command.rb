require "carbonmu/interactions/notify"

module CarbonMU
  class UnknownCommand < Command
    def execute
      Notify.one(@context.enacting_connection, "Unknown command: #{@context.raw_command}")
    end
  end
end
