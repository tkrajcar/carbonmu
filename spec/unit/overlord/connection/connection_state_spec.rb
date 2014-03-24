shared_examples 'a ConnectionState subclass' do
  let(:connection) { double('connection').as_null_object }

  describe '#new' do
    it 'takes a Connection arg' do
      instance = described_class.new(connection)
      expect(instance).to be_a(described_class)
    end
  end

  subject { described_class.new(connection) }

  it 'is a ConnectionState' do
    expect(subject).to be_a(Connection::ConnectionState)
  end

  it 'implements #handle_input' do
    expect {
      subject.handle_input('Hello World!')
    }.to implement_method
  end
end
