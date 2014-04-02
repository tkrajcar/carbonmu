module CarbonMU
  class SayCommand
    CommandManager.add :say do
      Notify.all("#{enacting_connection.id} spoke.")
    end

    CommandManager.add_syntax :say, /TODO/
  end
end
