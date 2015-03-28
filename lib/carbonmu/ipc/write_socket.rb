require "carbonmu/ipc/carbon_ipc_socket"
require "celluloid/zmq"

module CarbonMU
  class WriteSocket < CarbonIPCSocket
    def initialize(port = '15000')
      @zmq_socket = Celluloid::ZMQ::PushSocket.new
      @zmq_socket.connect("tcp://127.0.0.1:#{port}")
    end

    def send(message)
      @zmq_socket.send(message)
    end
  end
end
