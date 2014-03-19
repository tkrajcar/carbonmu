module CarbonMU
  class SayCommand < Command
    register_command :say do
      Notify.all("It speaked!")
    end
  end
end
