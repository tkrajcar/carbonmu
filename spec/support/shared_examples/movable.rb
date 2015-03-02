shared_examples_for "a Movable implementation" do
  it_behaves_like "a Tangible implementation"
  it { is_expected.to belong_to(:location).of_type(Tangible).as_inverse_of(:contents).with_index }
  it { is_expected.to validate_presence_of(:location) }
end
