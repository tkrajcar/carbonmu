require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection_id = SecureRandom.uuid
    command = "FOO"
    cc = CommandContext.new(enacting_connection_id: connection_id, command: command)
    cc.enacting_connection_id.should eq(connection_id)
    cc.command.should eq(command)
  end
end