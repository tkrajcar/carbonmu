require 'forwardable'
require "carbonmu/edge_router/interactive_connection"

module CarbonMU
  class TelnetConnection < InteractiveConnection
    include Celluloid::IO
    include Celluloid::Logger

    extend Forwardable
    def_delegators :@socket, :close

    attr_reader :socket

    def after_initialize(socket)
      @socket = socket
      async.run
    end

    def run
      info "*** Received telnet connection #{id} from #{socket.addr[2]}"
      @player = Player.first
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
      server.handle_interactive_command(input, self)
    end

    def before_shutdown
      @socket.close unless @socket.closed?
    end

    def quit
      write("Thanks for stopping by.")
      close
      terminate
    end

    def read
      @socket.readpartial(4096)
    end

    def write(message)
      @socket.write(message + "\n")
    end
  end
end
