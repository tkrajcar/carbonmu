require 'spec_helper'

describe ReadSocket do
  it_behaves_like "a CarbonIPCSocket implementation"

  it "raises on send(msg)" do
    expect { ReadSocket.new.send('foo') }.to raise_error(NotImplementedError)
  end

  it "reads from the underlying socket" do
    sock = ReadSocket.new
    sock.zmq_socket = double("zmq")
    expect(sock.zmq_socket).to receive(:read)
    sock.read
  end

  it "attempts to BIND to tcp://127.0.0.1:<specified port>" do
    port_number = rand(10000..20000)
    zmqsocket = double("zmqsocket")
    allow(zmqsocket).to receive(:connect)
    expect(zmqsocket).to receive(:bind).with("tcp://127.0.0.1:#{port_number}")
    allow(Celluloid::ZMQ::PullSocket).to receive(:new) { zmqsocket }
    ReadSocket.new(port_number)
  end

  it "knows its own port number" do
    port_number = rand(10000..20000)
    r = ReadSocket.new(port_number)
    expect(r.port_number).to eq(port_number)
  end

  context "ephemeral ports" do
    it "supports binding to an ephemeral port" do
      zmqsocket = double("zmqsocket")
      allow(zmqsocket).to receive(:bind)
      expect(zmqsocket).to receive(:bind).with("tcp://127.0.0.1:*")
      allow(Celluloid::ZMQ::PullSocket).to receive(:new) { zmqsocket }
      ReadSocket.new
    end

    it "returns a valid port number when bound to an ephemeral port" do
      expect(ReadSocket.new.port_number).to be_between(1024,65535)
    end

    it "returns a different port number on successive instantiations" do
      r1 = ReadSocket.new
      r2 = ReadSocket.new
      expect(r1.port_number).to_not eq(r2.port_number)
    end
  end
end
