module CarbonMU
  class SayCommand < Command
    command :say do
      Notify.all("#{enactor.socket.addr[2]} spoke.")
    end

    syntax :say, /TODO/
  end
end
