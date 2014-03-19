require 'spec_helper'

class TestCommand < Command; end

describe Command do
  context "#command" do
    it "registers a new command with proper args when a method is defined" do
      CommandManager.should_receive(:add).with(:testing_command, anything)
      TestCommand.command :testing_command do; "Pass"; end
    end

    it "inflects the class name to determine the command name if none is provided" do
      CommandManager.should_receive(:add).with(:test, anything)
      TestCommand.command do; "Pass"; end
    end

    it "raises ArgumentError if you don't pass a block" do
      expect { TestCommand.command }.to raise_error(ArgumentError)
    end
  end

  context "#syntax" do
    it "defines a syntax for a command" do
      CommandManager.should_receive(:add_syntax).with(:testing_command, /foo/)
      TestCommand.syntax :testing_command, /foo/
    end

    it "inflects the class name to determine the command name if none is provided" do
      CommandManager.should_receive(:add_syntax).with(:test, anything)
      TestCommand.syntax /foo/
    end
  end

  context "#inflected_command_name" do
    class TestinflectionCommand < Command; end
    it "inflects the command name from the class name properly" do
      TestinflectionCommand.inflected_command_name.should eq(:testinflection)
    end
  end
end