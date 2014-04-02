require 'spec_helper'

describe CommandManager do
  it 'prevents instantiation' do
    expect { subject.new }.to raise_error(NoMethodError)
  end

  context '#add' do
    it 'registers and stores a Command' do
      c = double("Command", prefix: "foo")
      subject.add c
      subject.commands[:foo].should eq(c)
    end
  end

  context '#execute' do
    it "handles a bad command" do
      Notify.should_receive(:all) #TODO
      context = double("CommandContext", command: "DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND", command_prefix: :DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND)
      subject.execute(context)
    end

    it "calls .execute on a good command" do
      command = double("Command", prefix: "testing_good_command")
      subject.add command
      context = double("CommandContext", command: "testing_good_command", command_prefix: :testing_good_command)
      expect(command).to receive(:execute).with(context)
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