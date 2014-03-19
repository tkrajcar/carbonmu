module CarbonMU
  module Parser
    def self.parse(full_command, command_context)
      command_prefix = full_command.split(" ")[0].to_sym
      if command_proc = CommandManager.commands[command_prefix]
        command_proc.call
      else
        # TODO handle a bad command
        Notify.all("bad command #{full_command}")
      end
    end
  end
end
