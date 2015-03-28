require "carbonmu/game_objects/movable"
require "carbonmu/game_objects/container"

module CarbonMU
  class Player < GameObject
    include Mongoid::Document
    include Movable
    include Container

    before_validation :default_location

    def default_location
      self.location ||= Room.starting
    end

    def self.superadmin
      find_by(_special: :superadmin_player)
    end
  end
end
