require 'spec_helper'

describe CommandManager do
  it 'registers and stores the proper data' do
    CommandManager.add :test_command_manager do
      "Foo"
    end
    CommandManager.commands[:test_command_manager].should be_a(Proc)
  end

  it 'prevents instantiation' do
    expect { CommandManager.new }.to raise_error(NoMethodError)
  end

  it "handles a bad command" do
    Notify.should_receive(:all) #TODO
    context = double("CommandContext")
    subject.execute("DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND", context)
  end

  it "dispatches a good command" do
    load_rel 'fixtures/test_parser_command.rb'
    subject.commands[:testing_parser_command].should_receive(:call)
    context = double("CommandContext")
    subject.execute("testing_parser_command", context)
  end
end