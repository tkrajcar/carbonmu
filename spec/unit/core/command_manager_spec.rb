require 'spec_helper'

module CarbonMU
  class MyCommand
    def self.cmd_foo(*args)
      "Hooray!"
    end
  end
end


describe CommandManager do
  it 'registers and stores the proper data' do
    CommandManager.register_command(:foo, MyCommand)
    CommandManager.commands[:foo].should eq({klass: MyCommand})
  end

  it 'sends the right method to the right place to execute a command' do
    CommandManager.register_command(:foo, MyCommand)
    MyCommand.should_receive("cmd_foo")
    CommandManager.execute("foo")
  end

  it 'raises an error if you attempt to register a command that doesn\'t have a method' do
    expect { CommandManager.register_command(:bar, MyCommand) }.to raise_error(NoMethodError)
  end

  it 'prevents instantiation' do
    expect { CommandManager.new }.to raise_error(NoMethodError)
  end
end