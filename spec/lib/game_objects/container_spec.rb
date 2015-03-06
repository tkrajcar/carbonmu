require 'spec_helper'

class MyContainer
  include Container
end

describe MyContainer do
  it_behaves_like "a Container"
end
