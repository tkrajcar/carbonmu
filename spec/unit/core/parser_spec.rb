require 'spec_helper'

describe Parser do
  it "should send commands to CommandManager.execute" do
    cc = double("CommandContext")
    CommandManager.should_receive(:execute).with("test_cmd",cc)
    subject.parse("test_cmd",cc)
  end
end