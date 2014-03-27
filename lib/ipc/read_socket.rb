module CarbonMU
  class ReadSocket < CarbonIPCSocket
    def initialize(port = 15000)
      @zmq_socket = Celluloid::ZMQ::PullSocket.new
      @zmq_socket.connect("tcp://127.0.0.1:#{port}")
    end

    def read
      @zmq_socket.read
    end
  end
end