module CarbonMU
  class Command
    def self.command(name, options = {}, &block)
      CommandManager.add(name, options, &block)
    end
  end
end
