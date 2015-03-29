require "carbonmu/game_objects/movable"
require "carbonmu/game_objects/container"
require "carbonmu/internationalization"

module CarbonMU
  class Player < GameObject
    include Mongoid::Document
    include Movable
    include Container

    field :locale, type: :string, default: "en" # TODO configurable game-wide default locale

    before_validation :default_location

    def default_location
      self.location ||= Room.starting
    end

    def self.superadmin
      find_by(_special: :superadmin_player)
    end

    def notify(message, args = {})
      CarbonMU.server.notify_player(self, message, args)
    end

    def notify_raw(message)
      CarbonMU.server.notify_player_raw(self, message)
    end

    def translate_message(message, translation_args = {})
      translation_args = translation_args.merge(locale: locale)
      Internationalization.t(message, translation_args)
    end
  end
end
