require 'spec_helper'

describe CarbonMU do
  it "has color methods available" do
    expect("string").to respond_to(:white)
  end

  it "has a translate method" do
    str = "Hi there"
    opts = {foo: "bar"}
    expect(CarbonMU::Internationalization).to receive(:translate).with(str, [opts])
    CarbonMU.t(str, opts)
  end
end
