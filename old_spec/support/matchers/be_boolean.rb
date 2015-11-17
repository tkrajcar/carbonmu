RSpec::Matchers.define :be_boolean do
  match do |actual|
    expect(actual).to satisfy { |x| x == true || x == false }
  end
end
