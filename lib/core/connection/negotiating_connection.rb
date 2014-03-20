module CarbonMU
  class Connection
    private 

    class NegotiatingConnection < ConnectionState
      class Step
        def initialize(&block)
          @op = block
        end

        def process(connection, input)
          @op.call(connection, input)
        end
      end

      class << self; attr_accessor :steps; end
      @steps = []

      @steps << Step.new do |conn, input|
        conn.name = input
        conn.write "Welcome, #{input}!\n"
        true
      end

      def initialize(*args)
        super
        @current_step = 0
        @conn.write "Enter your name: "
      end

      def handle_input(input)
        step = NegotiatingConnection.steps[@current_step]
        if step.process(@conn, input.chomp)
          @current_step += 1
        end

        if @current_step >= NegotiatingConnection.steps.length
          @conn.finalize
        end
      end
    end

  end
end
