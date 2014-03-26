require 'spec_helper'

describe EmbeddedDataEngine do
  include FakeFS::SpecHelpers
  let(:valid_persistable) {
    @as_hash = { "valid" => true }
    @as_json = MultiJson.dump(@as_hash)
    @valid_persistable = double("Persistable",
                                _id: "abc123",
                                fields: [:foo],
                                foo: "bar",
                                as_hash: @as_hash
                                )
  }

  before(:each) do
    @ede = EmbeddedDataEngine.new
    FakeFS.activate!
  end

  after(:each) do
    FakeFS.deactivate!
  end

  context ".persist" do
    it "raises if you attempt to persist an object that doesn't support _id" do
      obj = double("badobject")
      expect { @ede.persist(obj) }.to raise_error(ArgumentError, /\_id/)
    end

    it "raises if you attempt to persist an object that doesn't support fields" do
      obj = double("badobject", _id: "abc123")
      expect { @ede.persist(obj) }.to raise_error(ArgumentError, /fields/)
    end

    it "writes a good object to db/_id.json" do
      @ede.persist(valid_persistable)
      expect(File).to exist("db/#{valid_persistable._id}.json")
      File.open("db/#{valid_persistable._id}.json", 'rb') do |f|
        f.read.should eq(@as_json)
      end
    end
  end
end