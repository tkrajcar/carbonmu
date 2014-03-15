require 'spec_helper'

describe Connection do
  it 'writes to the underlying socket' do
    socket = double('socket')
    connection = Connection.new(socket)
    expect(socket).to receive(:write) { 'Hello World!' }
    connection.write('Hello World!')
  end
end
