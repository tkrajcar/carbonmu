module CarbonMU
  class Command
    attr_reader :prefix, :syntax, :block

    def initialize(params = {}, &block)
      raise ArgumentError, "expected block" unless block_given?
      @prefix = params[:prefix]
      @syntax = params[:syntax]
      @block = block
    end

    def execute(context)
      context.execute(@block)
    end
  end
end
