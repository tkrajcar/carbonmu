module CarbonMU
  module Parser
    def self.parse(full_command, command_context)
      # TODO ANSI interpolation goes here.
      CommandManager.execute(full_command, command_context)
    end
  end
end
