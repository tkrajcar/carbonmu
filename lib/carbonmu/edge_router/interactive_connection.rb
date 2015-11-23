module CarbonMU
  class InteractiveConnection
    include Celluloid::IO
    include Celluloid::Logger

    attr_accessor :player
    attr_reader :id

    finalizer :shutdown

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

    def server
      Celluloid::Actor[:server]
    end

    def shutdown
      before_shutdown
      #Actor[:edge_router].async.remove_connection(Actor.current) TODO
    end

    def before_shutdown
      nil # to be implemented by subclasses, if desired
    end
  end
end

