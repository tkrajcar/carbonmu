require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    connection = double("Connection")
    command = "FOO"
    cc = CommandContext.new(enacting_connection: connection, command: command)
    cc.enacting_connection.should eq(connection)
    cc.command.should eq(command)
  end

  context "command prefixes" do
    def test_context_command(command)
      CommandContext.new(command: command)
    end

    it "handles a simple case" do
      test_context_command("look hi").command_prefix.should eq(:look)
    end

    it "handles non-alpha chars without whitespace" do
      test_context_command('"hello there').command_prefix.should eq(:'"')
    end

    it "removes switches" do
      test_context_command("command/switch foo").command_prefix.should eq(:command)
    end

    it "handles single words" do
      test_context_command("foo").command_prefix.should eq(:foo)
    end
  end
end