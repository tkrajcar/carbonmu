require 'spec_helper'

describe Server do
  it "loads Mongoid configuration" do
    expect(Mongoid::Tasks::Database).to receive(:create_indexes)
    Server.initialize_database
    expect(Mongoid.configured?).to eq(true)
  end
end
