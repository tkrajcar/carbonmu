require 'spec_helper'

describe ReadSocket do
  it_behaves_like "a CarbonIPCSocket implementation"

  it "raises on send(msg)" do
    expect { ReadSocket.new.send('foo') }.to raise_error(NotImplementedError)
  end

  it "reads from the underlying socket" do
    sock = ReadSocket.new
    sock.zmq_socket = double("zmq")
    sock.zmq_socket.should_receive(:read)
    sock.read
  end

  it "attempts to CONNECT to tcp://127.0.0.1:<specified port>" do
    port_number = rand(10000..20000)
    zmqsocket = double("zmqsocket")
    zmqsocket.stub(:connect).with(anything)
    zmqsocket.should_receive(:connect).with("tcp://127.0.0.1:#{port_number}")
    Celluloid::ZMQ::PullSocket.stub(:new) { zmqsocket }
    ReadSocket.new(port_number)
  end
end