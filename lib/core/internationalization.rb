require "i18n"
require "i18n/backend/fallbacks"

module CarbonMU
  module Internationalization

    def self.setup
      I18n.load_path = ["config/locales/en.yml"] # TODO look for all locales, TODO support for plugins too.
    end

    def self.translate(str, *opts)
      I18n.t(str, opts)
    end
  end
end
