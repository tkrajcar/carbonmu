module CarbonMU
  class SayCommand < Command
    command do
      Notify.all("#{enactor.id} spoke.")
    end

    syntax /TODO/
  end
end
