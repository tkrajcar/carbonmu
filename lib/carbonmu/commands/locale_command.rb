# TODO TEMP
module CarbonMU
  class LocaleCommand < Command
    syntax /^locale (?<locale>.*)/
    syntax /^do (?<text>.*)/

    def execute
      @player.locale = @params[:locale]
      @player.notify_raw "Locale changed to #{@params[:locale]}."
    end
  end
end
