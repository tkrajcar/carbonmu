module CarbonMU
  class CommandContext
    attr_reader :enactor, :enacting_connection, :raw_command, :command, :params

    def initialize(params)
      @enactor = params[:enactor] || nil
      @enacting_connection = params[:enacting_connection] || nil
      @raw_command = params[:raw_command] || ""
      @command = params[:command] || nil
      @params = {}
    end

    def load_params
      command.syntax.each do |syntax|
        if matchdata = syntax.match(raw_command)
          matchdata.names.each { |k| @params[k.to_sym] = matchdata[k] }
          break
        end
      end
    end

    def execute
      load_params if command.syntax
      self.instance_eval &@command.block
    end
  end
end
