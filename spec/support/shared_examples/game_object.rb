shared_examples_for "a GameObject or descendant" do
  it { is_expected.to be_stored_in :game_objects }
  it { is_expected.to have_fields(:name, :description, :_special) }
  it { is_expected.to have_index_for(_special: 1) }
  it { is_expected.to validate_uniqueness_of(:_special).allow_blank?(true) }
end
