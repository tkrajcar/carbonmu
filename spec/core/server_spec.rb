require 'spec_helper'

describe Server do
  context "minimal objects" do
    before(:each) { Server.create_starter_objects }

    it "should create the starter Room" do
      r = Room.where(_special: :starting_room).first
      expect(r.class).to eq(Room)
      expect(r.name).to eq("Starting Room")
      expect(r.description).to eq("This is the starting room for newly-created players. Feel free to rename and re-describe it.")
    end

    it "should create the lost & found Room" do
      r = Room.where(_special: :lostandfound_room).first
      expect(r.class).to eq(Room)
      expect(r.name).to eq("Lost & Found Room")
      expect(r.description).to eq("This is the room where objects and players go if the thing that was holding them gets destroyed.")
    end

    it "should create the superadmin player" do
      p = Player.where(_special: :superadmin_player).first
      expect(p.class).to eq(Player)
      expect(p.name).to eq("Superadmin")
      expect(p.description).to eq("Obviously the most powerful of his race, it could kill us all.")
    end
  end
end
