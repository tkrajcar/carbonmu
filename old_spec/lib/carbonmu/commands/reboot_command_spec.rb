require 'spec_helper'

describe RebootCommand do
  context "syntax" do
    it { expect(command_parse_results("reboot")).to eq(parse_to(RebootCommand)) }
  end

  it "notifies all of reboot and signals server" do
    server = stub_carbonmu_server
    expect(server).to receive(:notify_all_players_raw).with(/Rebooting, please wait/)
    expect(Server).to receive(:trigger_reboot)
    run_command(RebootCommand)
  end
end
