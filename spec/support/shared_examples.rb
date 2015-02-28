shared_examples_for "a CarbonIPCSocket implementation" do
  it { should respond_to(:zmq_socket, :read, :send, :close) }
end

shared_examples_for "a Tangible implementation" do
  it { is_expected.to be_stored_in :tangibles }
  it { is_expected.to have_fields(:name, :description)}
end

shared_examples_for "a Movable implementation" do
  it { is_expected.to belong_to(:location).of_type(Tangible).as_inverse_of(:contents).with_index }
  it { is_expected.to validate_presence_of(:location) }

end
