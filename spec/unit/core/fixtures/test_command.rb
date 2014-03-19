module CarbonMU
  class TestCommand < Command
    self.register_command :testing_command, nil do
      "Pass."
    end
  end
end