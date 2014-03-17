module CarbonMU
  module CommandManager
    def self.register_command(command, klass)
      raise NoMethodError, "#{klass} doesn't define #{command}" unless klass.respond_to? "cmd_#{command}"
      @@commands ||= {}
      @@commands[command.to_sym] = {klass: klass}
    end

    def self.commands
      @@commands || {}
    end

    def self.execute(command, *args)
      return nil unless c = commands[command.to_sym]
      c[:klass].send("cmd_#{command}", args)
    end
  end
end
