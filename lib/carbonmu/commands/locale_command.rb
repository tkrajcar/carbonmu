# TODO TEMP
module CarbonMU
  class LocaleCommand < Command
    syntax /^locale (?<locale>.*)/
    syntax /^do (?<text>.*)/

    def execute
      @context.enactor.locale = @params[:locale]
      @context.enactor.notify_raw "Locale changed to #{@params[:locale]}."
    end
  end
end
