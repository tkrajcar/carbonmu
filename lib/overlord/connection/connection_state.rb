module CarbonMU
  class Connection
    private

    class ConnectionState
      def initialize(connection)
        @conn = connection
      end

      def handle_input(input)
        raise NotImplementedError
      end
    end

  end
end
