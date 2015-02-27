require 'spec_helper'

describe CarbonMU do
  it "has color methods available" do
    "string".white.on_red.should eq("\e[0;37;41mstring\e[0m")
  end
end