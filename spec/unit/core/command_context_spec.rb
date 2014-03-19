require 'spec_helper'

describe CommandContext do
  it "should store its attributes" do
    dc = double("Connection")
    cc = CommandContext.new(dc)
    cc.enactor.should eq(dc)
  end
end