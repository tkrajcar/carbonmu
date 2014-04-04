require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection = double("Connection")
    command = "FOO"
    cc = CommandContext.new(enacting_connection: connection, raw_command: command)
    cc.enacting_connection.should eq(connection)
    cc.raw_command.should eq(command)
  end
end