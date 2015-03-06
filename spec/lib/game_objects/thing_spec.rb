require 'spec_helper'

describe Thing do
  it_behaves_like "a GameObject or descendant"
  it_behaves_like "a Movable"
  it_behaves_like "a Container"
end
