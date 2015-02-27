require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection_id = "bar"
    command = "FOO"
    params = {boo: "bot"}
    cc = CommandContext.new(enacting_connection_id: connection_id, raw_command: command, params: params)
    expect(cc.enacting_connection_id).to eq(connection_id)
    expect(cc.raw_command).to eq(command)
    expect(cc.params).to eq(params)
  end
end
