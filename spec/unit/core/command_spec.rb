require 'spec_helper'

describe Command do
  it "registers a new command with proper args when a method is defined" do
    CommandManager.should_receive(:add)
    load_rel 'fixtures/test_command.rb'
  end
end