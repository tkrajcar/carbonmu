module CarbonMU
  class SayCommand < Command
    syntax /^say (?<text>.*)/
    syntax /^do (?<text>.*)/

    def execute
      response "emits.say", {name: "TODO Name", message: @params[:text].light_white} # Just a response for now, needs to be an emit.
    end
  end
end
