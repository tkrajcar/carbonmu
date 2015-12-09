module CarbonMU
  class InteractiveConnection
    attr_accessor :player
    attr_reader :id

    def initialize(arg = nil)
      @id = SecureRandom.uuid
      after_initialize(arg)
    end

    def after_initialize(arg)
      nil # to be implemented by subclasses, if desired
    end

    def run
      raise NotImplementedError
    end

    def write
      raise NotImplementedError
    end

    def server
      Celluloid::Actor[:server]
    end
  end
end

