shared_examples_for "a Movable" do
  it { is_expected.to belong_to(:location).of_type(GameObject).as_inverse_of(:contents).with_index }
  it { is_expected.to validate_presence_of(:location) }
end
