module CarbonMU
  class Connection
    attr_reader :socket

    def initialize(socket)
      @socket = socket
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
  end
end
