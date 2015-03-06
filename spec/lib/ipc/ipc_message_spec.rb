require 'spec_helper'

describe IPCMessage do
  it "sets its operation properly" do
    ipc = IPCMessage.new(:started)
    expect(ipc.op).to eq(:started)
  end

  it "supports equality" do
    ipc1 = IPCMessage.new(:write, connection_id: "123", output: "foo")
    ipc2 = IPCMessage.new(:write, connection_id: "123", output: "foo")
    expect(ipc1).to eq(ipc2)
  end

  it "accepts op parameters" do
    ipc = IPCMessage.new(:write, connection_id: "123", output: "foo")
    expect(ipc.params[:connection_id]).to eq("123")
    expect(ipc.params[:output]).to eq("foo")
  end

  it "supports direct method access for op parameters" do
    ipc = IPCMessage.new(:write, connection_id: "123", output: "foo")
    expect(ipc.params[:connection_id]).to eq(ipc.connection_id)
  end

  it "enforces required op parameters" do
    expect { IPCMessage.new(:write, connection_id: '123') }.to raise_error(ArgumentError,/output/)
  end

  it "raises if given an unknown op" do
    expect { IPCMessage.new(:definitely_not_a_good_op) }.to raise_error(ArgumentError,/definitely_not_a_good_op/)
  end

  it "knows how to serialize and unserialize itself" do
    original = IPCMessage.new(:write, connection_id: "123", output: "foo")
    round_trip = IPCMessage.unserialize(original.serialize)
    expect(round_trip).to eq(original)
  end
end
