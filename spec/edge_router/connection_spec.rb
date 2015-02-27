require 'spec_helper'

describe Connection do
  it "has a unique id" do
    c1 = Connection.new
    c2 = Connection.new
    expect(c1.id).to_not eq(c2)
  end
end
