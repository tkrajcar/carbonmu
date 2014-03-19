module CarbonMU
  class Command
    def self.register_command(name, options = {}, &block)
      CommandManager.add(name, options, &block)
    end
  end
end
