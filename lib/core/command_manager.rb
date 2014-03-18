module CarbonMU
  module CommandManager
    def self.add(prefix, &block)
      @commands ||= {}
      @commands[prefix.to_sym] = block
    end

    def self.commands
      @commands || {}
    end
  end
end
