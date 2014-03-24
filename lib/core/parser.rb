module CarbonMU
  module Parser
    def self.parse(command_context)
      # TODO ANSI interpolation goes here.
      CommandManager.execute(command_context)
    end
  end
end
