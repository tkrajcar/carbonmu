require "carbonmu/game_objects/movable"

module CarbonMU
  class Exit < GameObject
    include Mongoid::Document
    include Movable

    belongs_to :destination, class_name: "CarbonMU::Exit", inverse_of: :incoming_exits, index: true
  end
end
