module CarbonMU
  module CommandManager

    def self.add(command)
      @commands ||= {}
      @commands[command.prefix.to_sym] = command
    end

    def self.commands
      @commands || {}
    end

    def self.execute(command_context)
      if command = CommandManager.commands[command_context.command_prefix]
        command.execute(command_context)
      else
        # TODO handle a bad command
        Notify.all("bad command #{command_context.command_prefix}")
      end
    end

    def self.command_to_prefix(command)
      if [':', '"', '\\'].include? command[0]
        command[0].to_sym
      else
        command.match(/^(\w*)/)[0].to_sym
      end
    end
  end
end
