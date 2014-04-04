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
        puts "Checking #{syntax}"
        puts syntax.match(@raw_command)
        if(syntax.match @raw_command)
          puts "Match found! Text is #{text}"
        end
        puts "All done with #{syntax}"
      end
      puts "All done checking load_params"
    end

    def execute
      load_params if command.syntax
      puts "Params loaded."
      self.instance_eval &@command.block
    end
  end
end
