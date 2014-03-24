module CarbonMU
  class CommandContext
    attr_reader :enactor, :enacting_connection_id, :command

    def initialize(params)
      @enactor = params[:enactor] || nil
      @enacting_connection_id = params[:enacting_connection_id] || nil
      @command = params[:command] || ""
    end
  end
end
