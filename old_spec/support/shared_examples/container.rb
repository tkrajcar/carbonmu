shared_examples_for "a Container" do
  it { is_expected.to have_many(:contents).of_type(GameObject).with_foreign_key(:location) }
end
