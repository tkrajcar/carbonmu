require 'spec_helper'

describe CommandManager do
  it 'prevents instantiation' do
    expect { subject.new }.to raise_error(NoMethodError)
  end

  context '#add' do
    it 'registers and stores a Command' do
      c = double("Command", prefix: "foo")
      subject.add c
      subject.commands[:foo].should eq(c)
    end
  end
end