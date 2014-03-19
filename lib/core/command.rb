module CarbonMU
  class Command
    def self.command(name, options = {}, &block)
      CommandManager.add(name, options, &block)
    end

    def self.syntax(command_name, matcher)
      CommandManager.add_syntax(command_name, matcher)
    end
  end
end
