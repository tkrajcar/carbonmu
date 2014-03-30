require 'spec_helper'

describe Notify do
  context '.all' do
    it "writes to all connections with the input specified" do
      connection = double("connection")
      ConnectionManager.stub(:connections) { [connection] }
      connection.should_receive(:write).with("foo")
      Notify.all("foo")
    end
  end

  context '.one' do
    it "writes to the connection specified with the input" do
      connection = double("connection")
      connection.should_receive(:write).with("foo")
      Notify.one(connection, "foo")
    end
  end
end