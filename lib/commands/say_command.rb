module CarbonMU
  class SayCommand < Command
    syntax /^say (?<text>.*)/
    syntax /^do (?<text>.*)/

    def execute
      Notify.all("emits.say", {name: @context.enacting_connection.id, message: @params[:text].light_white})
    end
  end
end
