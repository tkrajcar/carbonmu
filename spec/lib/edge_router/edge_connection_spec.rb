require 'spec_helper'

describe EdgeConnection do
  it "has a unique id" do
    c1 = EdgeConnection.new
    c2 = EdgeConnection.new
    expect(c1.id).to_not eq(c2)
  end
end
