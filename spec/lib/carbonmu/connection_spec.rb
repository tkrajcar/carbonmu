require 'spec_helper'

describe Connection do
  let(:id) { "foo" }
  let(:connection) { Connection.new(id) }
  let(:message) { "Watson, come here" }
  let(:translation_args) { {foo: "bar"} }
  let(:player) { double(Player) }

  context ".id" do
    it "has an ID" do
      expect(connection.id).to eq(id)
    end

    it "won't let you set the ID" do
      expect { connection.id = id }.to raise_exception(NameError)
    end
  end

  context ".write_translated" do
    it "calls Server.write_to_connection" do
      server = stub_carbonmu_server
      expect(server).to receive(:write_to_connection).with(id, message, translation_args)
      connection.write_translated(message, translation_args)
    end
  end

  context ".write" do
    it "should alias to .write_translated" do
      expect(Connection.instance_method(:write)).to eq(Connection.instance_method(:write_translated))
    end
  end

  context ".write_raw" do
    it "calls Server.write_to_connection_raw" do
      server = stub_carbonmu_server
      expect(server).to receive(:write_to_connection_raw).with(id, message)
      connection.write_raw(message)
    end
  end

  context ".player" do
    it "is nil for new connections" do
      expect(connection.player).to eq(nil)
    end
  end
end
