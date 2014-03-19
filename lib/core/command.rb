module CarbonMU
  class Command
    def self.register_command(name, &block)
      CommandManager.add(name, &block)
    end
  end
end
