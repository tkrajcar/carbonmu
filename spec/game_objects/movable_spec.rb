require 'spec_helper'

class MyMovable
  include Movable
end

describe MyMovable do
  it_behaves_like "a Movable"
end
