require 'celluloid/zmq'

module CarbonMU
  class CarbonIPCSocket
    include Celluloid::ZMQ

    attr_accessor :zmq_socket

    def read
      raise NotImplementedError
    end

    def send(message)
      raise NotImplementedError
    end

    def close
      @zmq_socket.close if @zmq_socket
    end
  end
end
