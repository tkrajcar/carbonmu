module CarbonMU
  module CommandManager
    def self.add(prefix, options = {}, &block)
      @commands ||= {}
      @commands[prefix.to_sym] = { block: block }.merge(options)
    end

    def self.add_syntax(command_name, syntax)
      @commands[command_name][:syntax] ||= []
      @commands[command_name][:syntax] << syntax
    end

    def self.commands
      @commands || {}
    end

    def self.execute(full_command, command_context)
      command_prefix = full_command.split(" ")[0].to_sym

      if command = CommandManager.commands[command_prefix]
        command_context.instance_eval &command[:block]
      else
        # TODO handle a bad command
        Notify.all("bad command #{full_command}")
      end
    end
  end
end
