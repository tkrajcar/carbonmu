require 'spec_helper'

describe ConnectionManager do
  it 'creates a new connection' do
    c = ConnectionManager.add(double('socket'))
    c.should be_a(Connection)
  end

  it 'keeps track of its connections' do
    c = ConnectionManager.add(double('socket'))
    ConnectionManager.connections.should include(c)
  end
end
