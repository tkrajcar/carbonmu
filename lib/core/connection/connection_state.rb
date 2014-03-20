module CarbonMU
  class Connection
    private

    class ConnectionState
      def initialize(connection)
        @conn = connection
      end

      def handle_input(input)
        raise StandardError.new("Not implemented!")
      end
    end

  end
end
