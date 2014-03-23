require 'spec_helper'

describe Server do
  context '#handle_input' do
    it 'constructs a context for an incoming command' do
      s = Server.new
      fake_connection = double("Connection")
      expect(Parser).to receive(:parse).with('foo', kind_of(CommandContext))
      s.handle_input('foo',fake_connection)
    end
  end
end