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

  context '#execute' do
    it "handles a bad command" do
      Notify.should_receive(:all) #TODO
      context = double("CommandContext")
      subject.execute("DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND", context)
    end

    it "dispatches a good command to the Proc" do
      TestCommand.command :testing_good_command do; "Pass"; end
      subject.commands[:testing_good_command][:block].should_receive(:call)
      context = double("CommandContext")
      subject.execute("testing_good_command", context)
    end
  end
end