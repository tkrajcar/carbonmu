module CarbonMU
  class SayCommand
    c = Command.new(prefix: :say, syntax: [/^say (.*)$/]) do
      Notify.all("#{enacting_connection.id} spoke: #{@params}")
    end
    CommandManager.add c
  end
end
