require 'spec_helper'

class TestCommand < Command; end

describe Command do
  it "registers a new command with proper args when a method is defined" do
    CommandManager.should_receive(:add)
    TestCommand.register_command :testing_command do; "Pass"; end
  end
end