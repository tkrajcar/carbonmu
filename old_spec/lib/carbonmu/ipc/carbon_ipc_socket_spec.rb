require 'spec_helper'

describe CarbonIPCSocket do
  it_behaves_like "a CarbonIPCSocket implementation"

  it "closes a socket if one is defined" do
    sock = CarbonIPCSocket.new
    sock.zmq_socket = double("socket")
    expect(sock.zmq_socket).to receive(:close)
    sock.close
  end
end
