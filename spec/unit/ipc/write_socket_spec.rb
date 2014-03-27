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

  it "attempts to BIND to tcp://127.0.0.1:<specified port>" do
    port_number = rand(10000..20000)
    zmqsocket = double("zmqsocket")
    zmqsocket.stub(:bind).with(anything)
    zmqsocket.should_receive(:bind).with("tcp://127.0.0.1:#{port_number}")
    Celluloid::ZMQ::PushSocket.stub(:new) { zmqsocket }
    WriteSocket.new(port_number)
  end

  it "knows its own port number" do
    port_number = rand(10000..20000)
    w = WriteSocket.new(port_number)
    w.port_number.should eq(port_number)
  end

  context "ephemeral ports" do
    it "supports binding to an ephemeral port" do
      zmqsocket = double("zmqsocket")
      zmqsocket.stub(:bind).with(anything)
      zmqsocket.should_receive(:bind).with("tcp://127.0.0.1:*")
      Celluloid::ZMQ::PushSocket.stub(:new) { zmqsocket }
      WriteSocket.new
    end

    it "returns a valid port number when bound to an ephemeral port" do
      w = WriteSocket.new
      w.port_number.should be_between(1024,65535)
    end

    it "returns a different port number on successive instantiations" do
      w1 = WriteSocket.new
      w2 = WriteSocket.new
      w1.port_number.should_not eq(w2.port_number)
    end
  end
end