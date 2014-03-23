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
        Actor[:server].parse_input(buf, Celluloid::Actor.current)
      end
    rescue EOFError
      info "*** #{socket.addr[2]} disconnected"
      close
      # unregister
    end

    def shutdown
      @socket.close if @socket
    end

    def read
      @socket.readpartial(4096)
    end
  end
end
