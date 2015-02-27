require 'spec_helper'

shared_examples_for "a CarbonIPCSocket implementation" do
  it { should respond_to(:zmq_socket, :read, :send, :close) }
end

describe CarbonIPCSocket do
  it_behaves_like "a CarbonIPCSocket implementation"

  it "closes a socket if one is defined" do
    sock = CarbonIPCSocket.new
    sock.zmq_socket = double("socket")
    sock.zmq_socket.should_receive(:close)
    sock.close
  end
end