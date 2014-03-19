module CarbonMU
  class CommandContext
    attr_reader :enactor

    def initialize(enactor)
      @enactor = enactor
    end
  end
end
