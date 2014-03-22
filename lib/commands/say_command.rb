module CarbonMU
  class SayCommand < Command
    command do
      Notify.all("#{enactor.name} spoke.")
    end

    syntax /TODO/
  end
end
