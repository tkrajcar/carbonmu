module CarbonMU
  class Connection
    include Celluloid::IO
    include Celluloid::Logger

    finalizer :shutdown

    attr_reader :socket

    def initialize(socket)
      @socket = socket
    end

    def run
      info "*** Received connection from #{socket.addr[2]}"
      loop do
        buf = read
        Notify.all("#{socket.addr[2]} said: #{buf}")
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
