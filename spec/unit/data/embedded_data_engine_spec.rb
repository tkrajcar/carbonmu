require 'spec_helper'

describe EmbeddedDataEngine do
  let(:as_hash) { {"valid" => true} }
  let(:as_json) { MultiJson.dump(as_hash) }
  let(:valid_persistable) do
    double("Persistable",
           _id: "abc123",
           fields: [:foo],
           foo: "bar",
           as_hash: as_hash
          )
  end

  before(:each) do
    @ede = EmbeddedDataEngine.new("db_test")
  end

  after(:all) do
    FileUtils.rm_rf("db_test")
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
      expect(File).to exist("db_test/#{valid_persistable._id}.json")
      File.open("db_test/#{valid_persistable._id}.json", 'rb') do |f|
        f.read.should eq(as_json)
      end
    end
  end
end