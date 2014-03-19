module CarbonMU
  class Connection
    include Celluloid::IO
    include Celluloid::Logger

    finalizer :shutdown

    attr_reader :socket
    attr_reader :id

    def initialize(socket)
      @socket = socket
      @id = SecureRandom.uuid
    end

    def run
      info "*** Received connection #{id} from #{socket.addr[2]}"
      write "Connected. Your ID is #{id}\n"
      loop do
        buf = read
        command_context = CommandContext.new(self)
        Parser.parse(buf, command_context)
      end
    rescue EOFError
      info "*** #{socket.addr[2]} disconnected"
      close
      ConnectionManager.remove(Celluloid::Actor.current)
    end

    def close
      @socket.close
    end

    def read
      @socket.readpartial(4096)
    end

    def write(text)
      @socket.write(text)
    end

    def shutdown
      @socket.close if @socket
    end
  end
end
