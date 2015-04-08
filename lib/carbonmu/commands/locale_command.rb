# TODO TEMP
module CarbonMU
  class LocaleCommand < Command
    syntax /^locale (?<locale>.*)/
    syntax /^do (?<text>.*)/

    def execute
      @context.player.locale = @params[:locale]
      @context.player.notify_raw "Locale changed to #{@params[:locale]}."
    end
  end
end
