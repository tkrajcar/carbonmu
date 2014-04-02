require 'spec_helper'

describe Command do
  it "accepts parameters" do
    c = Command.new(prefix: "foo", syntax: [1, 2]) do; "pass"; end
    c.prefix.should eq('foo')
    c.syntax.should eq([1,2])
    c.block.should be_a(Proc)
  end

  it "can execute itself" do
    c = Command.new(prefix: "foo", syntax: [1, 2]) do; "pass"; end
    context = double("CommandContext", command: "foo", command_prefix: :testing_good_command)
    expect(context).to receive(:instance_eval).and_yield
    c.execute(context)
  end
end