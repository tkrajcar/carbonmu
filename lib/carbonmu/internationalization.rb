require "i18n"
require "i18n/backend/fallbacks"

module CarbonMU
  module Internationalization

    def self.setup
      I18n.enforce_available_locales = false
      core_locales_dir = File.expand_path("../../../config/locales", __FILE__)
      I18n.load_path = Dir["#{core_locales_dir}/*.yml"] # TODO Check support for plugins too.
    end

    def self.translate(str, *opts)
      I18n.t(str, opts)
    end
  end
end
