require 'spec_helper'

class TestCommand < Command; end

describe CommandManager do
  it 'prevents instantiation' do
    expect { subject.new }.to raise_error(NoMethodError)
  end

  context '#add' do
    it 'registers and stores a Proc' do
      subject.add :test_command_manager do; "Foo"; end
      subject.commands[:test_command_manager][:block].should be_a(Proc)
    end
  end

  context "#add_syntax" do
    it "stores a syntax" do
      subject.add :test_syntax_storage do; "Foo"; end
      matcher = /foo/
      subject.add_syntax :test_syntax_storage, matcher
      subject.commands[:test_syntax_storage][:syntax].should eq([matcher])
    end

    it "stores multiple syntaxes in order received" do
      subject.add :test_multi_syntax_storage do; "Foo"; end
      matcher1 = /foo/
      matcher2 = /bar/
      subject.add_syntax :test_multi_syntax_storage, matcher1
      subject.add_syntax :test_multi_syntax_storage, matcher2
      subject.commands[:test_multi_syntax_storage][:syntax].should eq([matcher1, matcher2])
    end
  end

  context '#execute' do
    it "handles a bad command" do
      Notify.should_receive(:all) #TODO
      context = double("CommandContext", command: "DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND", command_prefix: :DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND)
      subject.execute(context)
    end

    it "dispatches a good command to the Proc" do
      TestCommand.command :testing_good_command do; "Pass"; end
      context = double("CommandContext", command: "testing_good_command", command_prefix: :testing_good_command)
      expect(context).to receive(:instance_eval).and_yield
      subject.execute(context)
    end
  end

  context "command prefixes" do
    it "handles a simple case" do
      CommandManager.command_to_prefix("look hi").should eq(:look)
    end

    it "handles non-alpha chars without whitespace" do
      CommandManager.command_to_prefix('"hello there').should eq(:'"')
    end

    it "removes switches" do
      CommandManager.command_to_prefix("command/switch foo").should eq(:command)
    end

    it "handles single words" do
      CommandManager.command_to_prefix("foo").should eq(:foo)
    end
  end
end