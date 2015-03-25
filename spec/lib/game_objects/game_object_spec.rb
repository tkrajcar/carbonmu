require 'spec_helper'

describe GameObject do
  it_behaves_like "a GameObject or descendant"

  context ".description" do
    it "has a default description" do
      g = GameObject.new
      expect(g.description).to eq("You see nothing special.")
    end
  end
end
