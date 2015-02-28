require 'spec_helper'

describe Player do
  it_behaves_like "a Movable implementation"

  context ".superadmin" do
    it "returns the actual superadmin player" do
      expect(Player.superadmin._special).to eq(:superadmin_player)
    end
  end
end
