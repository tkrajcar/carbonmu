require 'forwardable'

module CarbonMU
  class TelnetConnection < Connection
    extend Forwardable
    def_delegators :@socket, :close, :write

    attr_reader :socket

    def initialize(socket)
      @socket = socket
      super()
    end

    def run
      info "*** Received telnet connection #{id} from #{socket.addr[2]}"
      write "Connected. Your ID is #{id}\n"
      loop do
        handle_input(read)
      end
    rescue EOFError, Errno::ECONNRESET
      info "*** Telnet connection #{id} disconnected"
      close
      terminate
    end

    def shutdown
      @socket.close unless @socket.closed?
      super
    end

    def read
      @socket.readpartial(4096)
    end
  end
end
