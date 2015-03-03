require 'spec_helper'

describe Player do
  it_behaves_like "a GameObject or descendant"
  it_behaves_like "a Movable"
  it_behaves_like "a Container"

  it "gets a location of the starter room if not otherwise specified" do
    p = Player.create!(location: nil)
    expect(p.location).to eq(Room.starting)
  end

  it "still can be given a location" do
    r = Room.create!
    p = Player.create!(location: r)
    expect(p.location).to eq(r)
  end

  context ".superadmin" do
    it "returns the actual superadmin player" do
      expect(Player.superadmin._special).to eq(:superadmin_player)
    end
  end
end
