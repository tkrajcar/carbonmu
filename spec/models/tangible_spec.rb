require 'spec_helper'

describe Tangible do
  it_behaves_like "a Tangible implementation"

  it { is_expected.to have_many(:contents).of_type(Movable).with_foreign_key(:location) }
end
