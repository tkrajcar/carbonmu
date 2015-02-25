require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection_id = "bar"
    command = "FOO"
    params = {boo: "bot"}
    cc = CommandContext.new(enacting_connection_id: connection_id, raw_command: command, params: params)
    cc.enacting_connection_id.should eq(connection_id)
    cc.raw_command.should eq(command)
    cc.params.should eq(params)
  end
end
