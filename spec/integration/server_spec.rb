require 'spec_helper'

describe "server" do
  it 'accepts connections' do
    CarbonMU.start_in_background
    s = TCPSocket.new 'localhost', 8421
    s.write("test!")
    s.readpartial(4096).should match(/Connected/) # TODO Fix this once we have a ping command.
  end
end
