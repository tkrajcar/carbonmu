module CarbonMU
  class Connection
    private

    class FinalizedConnection < ConnectionState
      def handle_input(input)
        command_context = CommandContext.new(@conn)
        Parser.parse(input, command_context)
      end
    end

  end
end
