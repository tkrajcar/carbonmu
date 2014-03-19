module CarbonMU
  module CommandManager
    def self.add(prefix, &block)
      @commands ||= {}
      @commands[prefix.to_sym] = block
    end

    def self.commands
      @commands || {}
    end

    def self.execute(full_command, command_context)
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
