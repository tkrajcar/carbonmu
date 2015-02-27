require 'spec_helper'

describe Connection do
  it "has a unique id" do
    c1 = Connection.new
    c2 = Connection.new
    c1.id.should_not eq(c2)
  end
end