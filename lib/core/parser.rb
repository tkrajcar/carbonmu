module CarbonMU
  module Parser
    def self.parse(enacting_connection_id, input)
      prefix = command_to_prefix(input)
      if command = CommandManager.commands[prefix]
        context = CommandContext.new(enacting_connection: ConnectionManager[enacting_connection_id], raw_command: input, command: command)
        context.execute
      else
        # TODO handle a bad command
        Notify.all("bad command #{prefix}")
      end
    end

    def self.command_to_prefix(command)
      [':', '"', '\\'].include?(command[0]) ? command[0].to_sym : command.match(/^(\w*)/)[0].to_sym
    end
  end
end
