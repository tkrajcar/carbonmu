module CarbonMU
  class CommandContext
    attr_reader :enacting_connection_id, :raw_command, :params

    def initialize(opts)
      @enacting_connection_id = opts[:enacting_connection_id] || nil
      @raw_command = opts[:raw_command] || ""
      @params = opts[:params] || {}
    end
  end
end
