module CarbonMU
  class Connection
    include Celluloid::IO
    include Celluloid::Logger

    attr_accessor :name
    attr_reader :id

    finalizer :shutdown

    def initialize(arg = nil)
      @id = SecureRandom.uuid
      after_initialize(arg)
    end

    def after_initialize(arg)
      nil # to be implemented by subclasses, if desired
    end

    def handle_input(input)
      input.chomp!
      Actor[:overlord].async.send_command_to_server(input, id)
    end

    def run
      raise NotImplementedError
    end

    def shutdown
      before_shutdown
      Actor[:overlord].async.remove_connection(Actor.current)
    end

    def before_shutdown
      nil # to be implemented by subclasses, if desired
    end
  end
end

