require 'spec_helper'

describe Exit do
  it_behaves_like "a GameObject or descendant"
  it_behaves_like "a Movable"
  it { is_expected.to belong_to(:destination).of_type(Exit).as_inverse_of(:incoming_exits).with_index }
end
