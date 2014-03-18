module CarbonMU
  class TestCommand < Command
    self.register_command :testing_command do
      "Pass."
    end
  end
end