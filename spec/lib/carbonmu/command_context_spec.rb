require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection = double(Connection)
    player = double(Player)
    allow(connection).to receive(:player) { player }
    command = "FOO"
    params = {boo: "bot"}
    cc = CommandContext.new(connection: connection, raw_command: command, params: params)
    expect(cc.connection).to eq(connection)
    expect(cc.player).to eq(player)
    expect(cc.raw_command).to eq(command)
    expect(cc.params).to eq(params)
  end
end
