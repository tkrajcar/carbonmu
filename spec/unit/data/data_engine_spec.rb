require 'spec_helper'

shared_examples_for "a DataEngine implementation" do
  it { should respond_to(:load, :persist) }
end

describe DataEngine do
  it_behaves_like "a DataEngine implementation"
end
