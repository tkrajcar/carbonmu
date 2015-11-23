require 'forwardable'
require "carbonmu/edge_router/interactive_connection"

module CarbonMU
  class TelnetConnection < InteractiveConnection
    extend Forwardable
    def_delegators :@socket, :close, :write

    attr_reader :socket

    def after_initialize(socket)
      @socket = socket
      async.run
    end

    def run
      info "*** Received telnet connection #{id} from #{socket.addr[2]}"
      write "Connected. Your ID is #{id}\n"
      loop do
        async.handle_input(read)
      end
    rescue EOFError, Errno::ECONNRESET
      info "*** Telnet connection #{id} disconnected"
      close
      terminate
    end

    def handle_input(input)
      input.chomp!
      debug "Received #{input} from Telnet ID #{id}."
      server.handle_command(input, self)
    end

    def before_shutdown
      @socket.close unless @socket.closed?
    end

    def read
      @socket.readpartial(4096)
    end
  end
end
