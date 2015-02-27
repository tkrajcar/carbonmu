require 'spec_helper'

describe WriteSocket do
  it_behaves_like "a CarbonIPCSocket implementation"

  it "raises on read" do
    expect { WriteSocket.new.read }.to raise_error(NotImplementedError)
  end

  it "writes to the underlying socket" do
    sock = WriteSocket.new
    sock.zmq_socket = double("zmq")
    sock.zmq_socket.should_receive(:send).with("foo")
    sock.send("foo")
  end

  it "attempts to CONNECT to tcp://127.0.0.1:<specified port>" do
    port_number = rand(10000..20000)
    zmqsocket = double("zmqsocket")
    zmqsocket.stub(:bind).with(anything)
    zmqsocket.should_receive(:connect).with("tcp://127.0.0.1:#{port_number}")
    Celluloid::ZMQ::PushSocket.stub(:new) { zmqsocket }
    WriteSocket.new(port_number)
  end
end