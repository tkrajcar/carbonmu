require 'spec_helper'

describe Room do
  it_behaves_like "a Tangible implementation"

  it { is_expected.to have_many(:incoming_exits).of_type(Exit).with_foreign_key(:destination) }

  context ".starting" do
    it "returns the actual starting room" do
      Server.create_starter_objects
      expect(Room.starting._special).to eq(:starting_room)
    end
  end

  context ".lostandfound" do
    it "returns the actual lost & found room" do
      Server.create_starter_objects
      expect(Room.lostandfound._special).to eq(:lostandfound_room)
    end
  end
end
