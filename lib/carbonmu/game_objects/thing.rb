require "carbonmu/game_objects/movable"
require "carbonmu/game_objects/container"

module CarbonMU
  class Thing < GameObject
    include Mongoid::Document
    include Movable
    include Container
  end
end
