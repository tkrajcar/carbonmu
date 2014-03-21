require 'spec_helper'

describe Connection::NegotiatingConnection do
  it_behaves_like 'a ConnectionState subclass'
  
  let(:connection) { double('connection').as_null_object }

  subject { described_class.new(connection) }

  describe '#handle_input' do
    # pending
  end
end
