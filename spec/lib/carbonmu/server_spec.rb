require 'spec_helper'

describe Server do
  context "minimal objects" do
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

  context "connections" do
    it "temporarily should set new connections to be the super-admin" do #TODO
      s = Server.new(true)
      s.add_connection(1)
      c = s.connections.first
      expect(c.player).to eq(Player.superadmin)
    end
  end

  context "notifying players" do
    let(:message) { "Watson, come here" }
    let(:translation_args) { { baz: "boof" } }
    let(:expected_sent_message) { "Watson, hier gekomen"}
    let(:player) { instance_double(Player) }

    before(:each) do
      @server = Server.new(true).wrapped_object
    end

    it ".notify_player calls notify_player_raw with translated result" do
      expect(@server).to receive(:notify_player_raw).with(player, expected_sent_message)
      expect(player).to receive(:translate_message).with(message, translation_args) { expected_sent_message }

      @server.notify_player(player, message, translation_args)
    end

    it ".notify_player_raw calls .write_to_connection_raw on all connections for Player" do
      c1 = double(Connection)
      c2 = double(Connection)
      expect(@server).to receive(:connections_for_player) { [c1, c2] }
      expect(@server).to receive(:write_to_connection_raw).with(c1, message)
      expect(@server).to receive(:write_to_connection_raw).with(c2, message)

      @server.notify_player_raw(player, message)
    end
  end

  context ".connections_for_player" do
    it "returns the right connections" do
      p1 = Player.new
      p2 = Player.new
      p3 = Player.new
      c1 = double(Connection, player: p1)
      c2 = double(Connection, player: p2)
      c3 = double(Connection, player: p1)
      server = Server.new(true).wrapped_object

      expect(server).to receive(:connections) { [c1, c2, c3] }.at_least(:once)
      expect(server.connections_for_player(p1)).to eq([c1, c3])
      expect(server.connections_for_player(p2)).to eq([c2])
      expect(server.connections_for_player(p3)).to eq([])
    end
  end

  context ".players" do
    it "returns the right players" do
      p1 = Player.new
      p2 = Player.new
      c1 = double(Connection, player: p1)
      c2 = double(Connection, player: p2)
      c3 = double(Connection, player: p1)
      server = Server.new(true).wrapped_object

      expect(server).to receive(:connections) { [c1, c2, c3] }
      expect(server.players).to eq([p1, p2])
    end
  end

  context ".write_to_connection_raw" do
    it "tells the edge router to write" do
      id = "foobar"
      message = "Bingo bango bongo"
      c = double(Connection, id: id)
      server = Server.new(true).wrapped_object

      expect(server).to receive(:send_write_to_edge_router).with(id, message)

      server.write_to_connection_raw(c, message)
    end
  end

  context ".notify_all_players" do
    it "calls .notify_player on each player" do
      message = "Widgets wadgets and wodgets."
      translation_args = { gizmo: "gadget"}
      p1 = double(Player)
      p2 = double(Player)
      server = Server.new(true).wrapped_object

      expect(server).to receive(:players) { [p1, p2]}
      expect(server).to receive(:notify_player).with(p1, message, translation_args)
      expect(server).to receive(:notify_player).with(p2, message, translation_args)

      server.notify_all_players(message, translation_args)
    end
  end

  context ".notify_all_players_raw" do
    it "calls .notify_player_raw on each player" do
      message = "Hippy happy hippos"
      p1 = double(Player)
      p2 = double(Player)
      server = Server.new(true).wrapped_object

      expect(server).to receive(:players) { [p1, p2]}
      expect(server).to receive(:notify_player_raw).with(p1, message)
      expect(server).to receive(:notify_player_raw).with(p2, message)

      server.notify_all_players_raw(message)
    end
  end
end
