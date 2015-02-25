require 'spec_helper'

class TestCommand < Command
  syntax "bar"
  syntax /foo/
end

describe Command do
  it "keeps track of defined syntaxes" do
    TestCommand.syntaxes.should eq ["bar", /foo/]
  end

  it "sends syntaxes to parser" do
    Parser.should_receive(:register_syntax).with("baz", duck_type(:syntax))
    Parser.should_receive(:register_syntax).with("bat", duck_type(:syntax))

    class ParseTestCommand < Command
      syntax "baz"
      syntax "bat"
    end
  end

  context "command contexts" do
    before(:each) do
      @context = double("Context").as_null_object
    end

    it "stores its context" do
      my_command = Command.new(@context)
      my_command.context.should eq(@context)
    end

    it "raises if .execute called directly on Command" do
      expect { Command.new(@context).execute}.to raise_exception(NotImplementedError)
    end
  end
end
