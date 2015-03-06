require 'spec_helper'

describe Connection do
  let(:id) { "foo" }
  let(:connection) { Connection.new(id) }
  let(:message) { "Watson, come here" }

  context ".id" do
    it "has an ID" do
      expect(connection.id).to eq(id)
    end

    it "won't let you set the ID" do
      expect { connection.id = id }.to raise_exception(NameError)
    end
  end

  context ".locale" do
    it "has a locale" do
      expect(connection.locale).to eq("en")
    end

    it "lets you set the locale" do
      c = Connection.new(id)
      c.locale = "nl"
      expect(c.locale).to eq("nl")
    end
  end

  context ".write" do
    it "sends .write to CarbonMU.server" do
      server = stub_carbonmu_server
      expect(server).to receive(:write_to_connection).with(id, message)
      connection.write(message)
    end
  end
end