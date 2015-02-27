require 'spec_helper'

describe Notify do
  before(:each) do
    @server = stub_carbonmu_server
  end

  context '.all' do
    it "writes to all connections with the input specified" do
      expect(@server).to receive(:write_to_all_connections).with("foo\n")
      Notify.all("foo")
    end
  end

  context '.one' do
    it "writes to the connection specified with the input" do
      connection = "id1"
      expect(@server).to receive(:write_to_connection).with(connection, "foo\n")
      Notify.one(connection, "foo")
    end
  end
end
