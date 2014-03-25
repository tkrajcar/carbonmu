require 'spec_helper'

describe ServerConnection do
  before(:each) do
    @id = double("id")
    @server = double("server")
    @serverconnection = ServerConnection.new(@id, @server)
  end

  it "stores its attributes" do
    @serverconnection.id.should eq(@id)
    @serverconnection.server.should eq(@server)
  end

  it "commands .server to write" do
    command = "foobar"
    @server.should_receive(:write_to_connection).with(@id, command)
    @serverconnection.write(command)
  end

end