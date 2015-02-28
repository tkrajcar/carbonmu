require 'spec_helper'

describe Room do
  it_behaves_like "a Tangible implementation"

  it { is_expected.to have_many(:incoming_exits).of_type(Exit).with_foreign_key(:destination) }
end
