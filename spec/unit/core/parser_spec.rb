require 'spec_helper'

describe Parser do
  it "handles a bad command" do
    Notify.should_receive(:all)
    context = double("CommandContext")
    subject.parse("DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND", context)
  end

  it "dispatches a good command" do
    load_rel 'fixtures/test_parser_command.rb'
    CommandManager.commands[:testing_parser_command].should_receive(:call)
    context = double("CommandContext")
    subject.parse("testing_parser_command", context)
  end
end