require 'spec_helper'

describe Reboot do
  it "notifies all of reboot and signals server" do
    expect(Notify).to receive(:all).with(/Rebooting, please wait/)
    expect(Server).to receive(:trigger_reboot)
    Reboot.reboot
  end
end
