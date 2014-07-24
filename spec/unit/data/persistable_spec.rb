require 'spec_helper'

class TestPersisted
  include Persistable

  field :foo
  read_only_field :read_only_foo
end

describe Persistable do
  context "regular fields" do
    it "supports registering fields as persisted" do
      TestPersisted.fields.should include(:foo)
    end

    it "defines an accessor for fields" do
      tester = TestPersisted.new
      tester.should respond_to(:foo)
      tester.should respond_to(:foo=)
    end

    it "doesn't let you directly edit klass.fields" do
      TestPersisted.should_not respond_to(:fields=)
    end

    it "supports .fields on both the class and an instance" do
      tester = TestPersisted.new
      TestPersisted.should respond_to(:fields)
      tester.should respond_to(:fields)
    end
  end

  context "read-only fields" do
    it "supports registering read-only fields as persisted" do
      TestPersisted.fields.should include(:read_only_foo)
    end

    it "supports read-only fields" do
      tester = TestPersisted.new
      tester.should respond_to(:read_only_foo)
      tester.should_not respond_to(:read_only_foo=)
    end
  end

  context "_id" do
    it "lets you retrieve a _id" do
      tester = TestPersisted.new
      tester.should respond_to(:_id)
    end

    it "generates _id uniquely" do
      tester = TestPersisted.new
      other_tester = TestPersisted.new
      tester._id.should_not eq(other_tester._id)
    end

    it "allows for setting _id" do
      tester = TestPersisted.new
      tester._id = "abc123"
      tester._id.should eq("abc123")
    end

    it "doesn't allow setting _id twice" do
      tester = TestPersisted.new
      tester._id = "abc123"
      expect {tester._id = "def234"}.to raise_error(RuntimeError)
      tester._id.should eq("abc123")
    end
  end

  it "sends .save to DataManager" do
    tester = TestPersisted.new
    DataManager.should_receive(:persist).with(tester)
    tester.save
  end

  it "knows how to convert itself into a hash" do
    Timecop.freeze do
      tester = TestPersisted.new
      tester.foo = "bar"
      expected_hash = {_id: tester._id, foo: "bar", read_only_foo: nil, _class: "TestPersisted", _created: DateTime.now}
      tester.as_hash.should eq(expected_hash)
    end
  end

  context ".from_hash" do
    it "knows how to convert a hash back into an instance of itself" do
      input_hash = {"_id" => "abc123", "foo" => "bar", "_class" => "TestPersisted"}
      obj = TestPersisted.from_hash(input_hash)
      obj.should be_a(TestPersisted)
      obj._id.should eq("abc123")
      obj.foo.should eq("bar")
    end

    it "raises an error if called with a hash that doesn't include _class" do
      input_hash = {foo: 'bar'}
      expect { TestPersisted.from_hash(input_hash) }.to raise_error(ArgumentError)
    end
  end

  context "_created" do
    it "sets a created timestamp automatically" do
      Timecop.freeze do
        tester = TestPersisted.new
        tester._created.should eq(DateTime.now)
      end
    end
    it "won't let you set _created" do
      tester = TestPersisted.new
      expect {tester._created = "foo"}.to raise_error(NoMethodError)
    end
  end
end
