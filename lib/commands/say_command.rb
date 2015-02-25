module CarbonMU
  class SayCommand < Command
    syntax /^say (?<text>.*)/
    syntax /^do (?<text>.*)/

    def execute
      Notify.all("#{@context.enacting_connection_id} says, \"#{@params[:text].light_white}\"")
    end
  end
end
