module CarbonMU
  class ReadSocket < CarbonIPCSocket
    def initialize(port = '*')
      @zmq_socket = Celluloid::ZMQ::PullSocket.new
      @zmq_socket.bind("tcp://127.0.0.1:#{port}")
    end

    def read
      @zmq_socket.read
    end

    def port_number
      raw_endpoint = @zmq_socket.get(::ZMQ::LAST_ENDPOINT) || nil
      return nil if raw_endpoint.nil?
      raw_endpoint.match(/\:(\d+)/)[1].to_i
    end    
  end
end