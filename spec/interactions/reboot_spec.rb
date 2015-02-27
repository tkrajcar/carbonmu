require 'spec_helper'

describe Reboot do
  it "notifies all of reboot and signals server" do
    Notify.should_receive(:all).with(/Rebooting, please wait/)
    Server.should_receive(:trigger_reboot)
    Reboot.reboot
  end
end