require 'forwardable'

module CarbonMU
  class TelnetConnection
    extend Forwardable
    def_delegators :@socket, :close, :write

    include Celluloid::IO
    include Celluloid::Logger
    finalizer :shutdown

    attr_accessor :name
    attr_reader :socket, :id

    def initialize(socket)
      @socket = socket
      @id = SecureRandom.uuid
      async.run
    end

    def run
      info "*** Received connection #{id} from #{socket.addr[2]}"
      write "Connected. Your ID is #{id}\n"
      loop do
        buf = @socket.read
        Actor[:server].handle_input(buf, Actor.current)
      end
    rescue EOFError, Errno::ECONNRESET
      info "*** #{id} disconnected"
      close
      Actor[:overlord].remove_connection(Actor.current)
      terminate
    end

    def shutdown
      @socket.close unless @socket.closed?
    end

    def read
      @socket.readpartial(4096)
    end
  end
end
