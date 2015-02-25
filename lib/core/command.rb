module CarbonMU
  class Command
    class << self
      def syntax(value)
        @syntaxes ||= []
        @syntaxes << value
        Parser.register_syntax(value, self)
      end

      def syntaxes
        @syntaxes
      end
    end

    attr_reader :context

    def initialize(context)
      @context = context
      @params = context.params
    end

    def execute
      raise NotImplementedError
    end
  end
end
