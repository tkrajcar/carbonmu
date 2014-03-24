require 'spec_helper'

describe Parser do
  it "should send commands to CommandManager.execute" do
    cc = double("CommandContext")
    CommandManager.should_receive(:execute).with(cc)
    subject.parse(cc)
  end
end