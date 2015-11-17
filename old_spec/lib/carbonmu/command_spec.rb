require 'spec_helper'

class TestCommand < Command
  syntax "bar"
  syntax /foo/
end

describe Command do
  it "keeps track of defined syntaxes" do
    expect(TestCommand.syntaxes).to eq(["bar", /foo/])
  end

  it "unpacks the incoming command context into instance variables" do
    context = double("Context")
    value = "FooBar"
    allow(context).to receive(:attributes) { [:foo] }
    allow(context).to receive(:foo) { value }
    t = TestCommand.new(context)
    expect(t.instance_variable_get(:@foo)).to eq(value)
  end

  context "command contexts" do
    before(:each) do
      @context = double("Context").as_null_object
    end

    it "stores its context" do
      my_command = Command.new(@context)
      expect(my_command.context).to eq(@context)
    end

    it "raises if .execute called directly on Command" do
      expect { Command.new(@context).execute}.to raise_exception(NotImplementedError)
    end
  end
end
