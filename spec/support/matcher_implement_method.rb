RSpec::Matchers.define :implement_method do
  match do |block|
    begin block.call
    rescue NotImplementedError
      false
    rescue
      true
    end
  end
end
