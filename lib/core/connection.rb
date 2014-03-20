require 'forwardable'

module CarbonMU
  class Connection
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
      @state = nil
    end

    def finalize
      @state = FinalizedConnection.new(self)
      Notify.all "#{@name} has connected.\n"
    end

    def run
      info "*** Received connection #{id} from #{socket.addr[2]}"
      write "Connected. Your ID is #{id}\n"
      @state = NegotiatingConnection.new(self)
      loop do
        @state.handle_input(read)
      end
    rescue EOFError
      info "*** #{socket.addr[2]} disconnected"
      close
      ConnectionManager.remove(Celluloid::Actor.current)
    end

    private

    def read
      @socket.readpartial(4096)
    end

    def shutdown
      @socket.close if @socket
    end
  end
end
