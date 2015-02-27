shared_examples_for "a CarbonIPCSocket implementation" do
  it { should respond_to(:zmq_socket, :read, :send, :close) }
end

shared_examples_for "a DataEngine implementation" do
  it { should respond_to(:load, :persist) }
end
