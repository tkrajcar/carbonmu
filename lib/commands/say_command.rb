module CarbonMU
  class SayCommand < Command
    register_command :say do
      puts "Pass."
    end
  end
end
