require 'spec_helper'

class TestCommand < Command; end

describe Command do
  it "registers a new command with proper args when a method is defined" do
    CommandManager.should_receive(:add)
    TestCommand.command :testing_command do; "Pass"; end
  end

  it "defines a syntax for a command" do
    CommandManager.should_receive(:add_syntax).with(:testing_command, /foo/)
    TestCommand.syntax :testing_command, /foo/
  end
end