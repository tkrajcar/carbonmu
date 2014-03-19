module CarbonMU
  class SayCommand < Command
    command :say do
      Notify.all("#{enactor.id} spoke.")
    end

    syntax :say, /TODO/
  end
end
