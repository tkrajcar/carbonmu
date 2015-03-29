require 'spec_helper'

describe CarbonMU do
  it "has color methods available" do
    expect("string").to respond_to(:white)
  end
end
