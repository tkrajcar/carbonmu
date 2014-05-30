module CarbonMU
  class SayCommand
    c = Command.new(prefix: :say, syntax: [/^say (?<text>.*)/]) do
      Notify.all("#{enacting_connection.id} says, \"#{@params[:text]}\"")
    end
    CommandManager.add c
  end
end
