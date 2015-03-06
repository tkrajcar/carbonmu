module CarbonMU
  class Connection
    attr_reader :id
    attr_accessor :locale
    # TODO probably need edge type (:telnet, :ssl, etc), or at least interactive true/false
    def initialize(id)
      @id = id
      @locale = "en" # TODO configurable default locale
    end

    def write_translated(msg, args = {})
      translation_args = args.merge(locale: @locale)
      CarbonMU.server.write_to_connection(id, I18n.t(msg, translation_args) + "\n")
    end
  end
end
