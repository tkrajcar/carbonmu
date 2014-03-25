module CarbonMU
  class CommandContext
    attr_reader :enactor, :enacting_connection, :command

    def initialize(params)
      @enactor = params[:enactor] || nil
      @enacting_connection = params[:enacting_connection] || nil
      @command = params[:command] || ""
    end
  end
end
