require "carbonmu/parser"

module CarbonMU
  class Command
    class << self

      def syntax(value)
        @syntaxes ||= []
        @syntaxes << value
      end

      def syntaxes
        @syntaxes || []
      end

      def inherited(child)
        @command_classes ||= []
        @command_classes << child
      end

      def command_classes
        @command_classes || []
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
