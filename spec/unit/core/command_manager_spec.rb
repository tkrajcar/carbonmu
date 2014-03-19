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
end