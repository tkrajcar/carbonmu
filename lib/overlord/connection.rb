module CarbonMU
  class Connection
    include Celluloid::IO
    include Celluloid::Logger

    attr_accessor :name
    attr_reader :id

    finalizer :shutdown

    def initialize
      @id = SecureRandom.uuid
    end

    def handle_input(input)
      input.chomp!
      Actor[:overlord].async.send_command_to_server(input, id)
    end

    def run
      raise NotImplementedError
    end

    def shutdown
      Actor[:overlord].async.remove_connection(Actor.current)
    end
  end
end

