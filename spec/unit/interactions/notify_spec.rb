require 'spec_helper'

describe Notify do
  context '.all' do
    it "writes to all connections with the input specified" do
      server = double("server")
      CarbonMU.stub(:server) { server }
      server.should_receive(:write_to_all_connections).with("foo\n")
      Notify.all("foo")
    end
  end

  context '.one' do
    it "writes to the connection specified with the input" do
      connection = "id1"
      server = double("server")
      CarbonMU.stub(:server) { server }
      server.should_receive(:write_to_connection).with(connection, "foo\n")
      Notify.one(connection, "foo")
    end
  end
end
