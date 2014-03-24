require 'spec_helper'

describe Server do
  context '#handle_input' do
    it 'constructs a context for an incoming command' do
      fakeserver = TCPServer.open '0.0.0.0', 13759
      s = Server.new 'localhost', 13759
      expect(Parser).to receive(:parse).with(kind_of(CommandContext))
      s.handle_command('foo',SecureRandom.uuid)
    end
  end
end