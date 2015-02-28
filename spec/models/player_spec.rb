require 'spec_helper'

describe Player do
  it_behaves_like "a Movable implementation"

  context ".superadmin" do
    it "returns the actual superadmin player" do
      Server.create_starter_objects
      expect(Player.superadmin._special).to eq(:superadmin_player)
    end
  end
end
