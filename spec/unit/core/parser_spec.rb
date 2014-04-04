require 'spec_helper'

describe Parser do
  context '.parse' do
    it "handles a bad command" do
      Notify.should_receive(:all) #TODO
      CommandManager.commands.stub(:[]) { false }
      subject.parse(1, "DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND")
    end

    it "calls .execute on a good command context" do
      command = double("Command", syntax: [])
      CommandManager.commands.stub(:[]) { command }
      expect_any_instance_of(CommandContext).to receive(:execute)
      subject.parse(1, "testing_good_command")
    end
  end

  context "command prefixes" do
    it "handles a simple case" do
      Parser.command_to_prefix("look hi").should eq(:look)
    end

    it "handles non-alpha chars without whitespace" do
      Parser.command_to_prefix('"hello there').should eq(:'"')
    end

    it "removes switches" do
      Parser.command_to_prefix("command/switch foo").should eq(:command)
    end

    it "handles single words" do
      Parser.command_to_prefix("foo").should eq(:foo)
    end
  end
end