require "carbonmu/interactions/notify"

# TODO TEMP
module CarbonMU
  class LocaleCommand < Command
    syntax /^locale (?<locale>.*)/
    syntax /^do (?<text>.*)/

    def execute
      @context.enacting_connection.locale = @params[:locale]
      Notify.one(@context.enacting_connection, "Locale changed to #{@params[:locale]}.")
    end
  end
end
