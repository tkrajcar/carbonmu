module CarbonMU
  class SayCommand < Command
    command :say do
      Notify.all("It speaked!")
    end

    syntax :say, /TODO/
  end
end
