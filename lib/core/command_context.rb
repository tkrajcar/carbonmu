module CarbonMU
  class CommandContext
    attr_reader :enactor, :enacting_connection, :command

    def initialize(params)
      @enactor = params[:enactor] || nil
      @enacting_connection = params[:enacting_connection] || nil
      @command = params[:command] || ""
    end

    def command_prefix
      if [':', '"', '\\'].include? command[0]
        command[0].to_sym
      else
        command.match(/^(\w*)/)[0].to_sym
      end
    end
  end
end
