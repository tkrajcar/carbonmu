RSpec::Matchers.define :implement_method do
  match do |block|
    begin block.call
    rescue NotImplementedError
      true
    rescue
      false
    end
  end
end
