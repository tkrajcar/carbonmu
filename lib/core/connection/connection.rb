module CarbonMU
  class Connection
    include Celluloid::IO
    include Celluloid::Logger

    attr_accessor :name
    attr_reader :id

    finalizer :shutdown

    def initialize
      @id = SecureRandom.uuid
      async.run
    end

    def handle_input(input)
      Actor[:server].handle_input(buf, Actor.current)
    end

    def run
      raise NotImplementedError
    end

    def shutdown
      Actor[:overlord].async.remove_connection(Actor.current)
    end
  end
end

