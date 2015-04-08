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
    expect(cc.attributes).to eq(CommandContext.attributes)
  end

  context ".attributes" do
    it "has the correct attributes listed" do
      expect(CommandContext.attributes).to eq [:connection, :player, :raw_command, :params]
    end
  end
end
