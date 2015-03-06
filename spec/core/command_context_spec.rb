require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection = double(Connection)
    command = "FOO"
    params = {boo: "bot"}
    cc = CommandContext.new(enacting_connection: connection, raw_command: command, params: params)
    expect(cc.enacting_connection).to eq(connection)
    expect(cc.raw_command).to eq(command)
    expect(cc.params).to eq(params)
  end
end
