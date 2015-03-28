require 'spec_helper'

describe RebootCommand do
  context "syntax" do
    it { expect(command_parse_results("reboot")).to eq(parse_to(RebootCommand)) }
  end

  it "notifies all of reboot and signals server" do
    expect(Notify).to receive(:all).with(/Rebooting, please wait/)
    expect(Server).to receive(:trigger_reboot)
    run_command(RebootCommand)
  end
end
