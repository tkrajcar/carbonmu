module CarbonMU
  class Command
    def self.command(*args, &block)
      raise ArgumentError, "Expected block!" unless block_given?
      name = args[0] || inflected_command_name
      options = args[1] || {}
      CommandManager.add(name, options, &block)
    end

    def self.syntax(*args)
      command_name = args.length > 1 ? args[0] : inflected_command_name
      CommandManager.add_syntax(command_name, args.last)
    end

    def self.inflected_command_name
      self.to_s.match(/([A-z]*)Command/)[1].downcase.to_sym
    end
  end
end
