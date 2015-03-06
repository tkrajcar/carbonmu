module CarbonMU
  class CommandContext
    attr_reader :enacting_connection, :raw_command, :params

    def initialize(opts)
      @enacting_connection = opts[:enacting_connection] || nil
      @raw_command = opts[:raw_command] || ""
      @params = opts[:params] || {}
    end
  end
end
