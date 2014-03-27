require 'spec_helper'

class EDELoadTest
  include Persistable
  field :foo
end

describe EmbeddedDataEngine do
  let(:as_hash) { {"_id" => "abc123", "foo" => "bar", "_class" => "EDELoadTest"} }
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

  it_behaves_like "a DataEngine implementation"

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

  context ".load" do
    it "raises ObjectNotFoundError if given a bad id" do
      expect { @ede.load("DEFINITELY_NOT_A_GOOD_ID") }.to raise_error(ObjectNotFoundError)
    end

    it "loads a good id and parses it" do
      File.open("db_test/abc123.json",'w') { |f| f.write as_json }
      obj = @ede.load("abc123")
      obj._id.should eq("abc123")
      obj.foo.should eq("bar")
    end

    it "raises InvalidObjectError if it finds a file whose internal _id does not match its filename" do
      File.open("db_test/definitely-bad.json",'w') { |f| f.write as_json }
      expect { @ede.load("definitely-bad") }.to raise_error(InvalidObjectError)
    end
  end
end
