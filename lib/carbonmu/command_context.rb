module CarbonMU
  class CommandContext
    attr_reader :connection, :enactor, :raw_command, :params

    def initialize(opts)
      @connection = opts[:connection] || nil
      @enactor = @connection.player || nil
      @raw_command = opts[:raw_command] || ""
      @params = opts[:params] || {}
    end
  end
end
