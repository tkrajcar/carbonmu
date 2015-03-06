require 'spec_helper'

describe Notify do
  before(:each) do
    @server = stub_carbonmu_server
    allow(@server).to receive(:connections) { [connection1, connection2] }
  end

  let(:connection1) { double(Connection) }
  let(:connection2) { double(Connection) }

  context '.all' do
    it "writes to all connections with the input specified" do
      expect(connection1).to receive(:write).with("foo\n")
      expect(connection2).to receive(:write).with("foo\n")
      Notify.all("foo")
    end
  end

  context '.one' do
    it "writes to the connection specified with the input" do
      expect(connection1).to receive(:write).with("foo\n")
      Notify.one(connection1, "foo")
    end
  end
end
