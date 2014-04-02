module CarbonMU
  class SayCommand
    c = Command.new(prefix: :say) do
      Notify.all("#{enacting_connection.id} spoke.")
    end
    CommandManager.add c
  end
end
