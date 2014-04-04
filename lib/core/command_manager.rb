module CarbonMU
  module CommandManager

    def self.add(command)
      @commands ||= {}
      @commands[command.prefix.to_sym] = command
    end

    def self.commands
      @commands || {}
    end
  end
end
