module CarbonMU
  class SayCommand < Command
    command do
      Notify.all("#{enacting_connection.id} spoke.")
    end

    syntax /TODO/
  end
end
