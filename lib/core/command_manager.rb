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

    def self.execute(command_context)
      if command = CommandManager.commands[command_context.command_prefix]
        command_context.instance_eval &command[:block]
      else
        # TODO handle a bad command
        Notify.all("bad command #{command_context.command_prefix}")
      end
    end
  end
end
