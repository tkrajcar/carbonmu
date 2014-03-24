module CarbonMU
  class Connection
    private

    class FinalizedConnection < ConnectionState
      def handle_input(input)
        command_context = CommandContext.new(enacting_connection_id: @conn.id, command: input)
        Parser.parse(command_context)
      end
    end

  end
end
