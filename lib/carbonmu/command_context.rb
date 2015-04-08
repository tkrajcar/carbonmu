module CarbonMU
  class CommandContext
    attr_reader :connection, :player, :raw_command, :params

    def attributes
      CommandContext.attributes
    end

    def self.attributes
      [:connection, :player, :raw_command, :params]
    end

    def initialize(opts)
      @connection = opts[:connection] || nil
      @player = @connection.player || nil
      @raw_command = opts[:raw_command] || ""
      @params = opts[:params] || {}
    end
  end
end
