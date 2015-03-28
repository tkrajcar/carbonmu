require "carbonmu/game_objects/container"

module CarbonMU
  class Room < GameObject
    include Mongoid::Document
    include Container

    has_many :incoming_exits, class_name: "CarbonMU::Exit", foreign_key: :destination

    def self.starting
      find_by(_special: :starting_room)
    end

    def self.lostandfound
      find_by(_special: :lostandfound_room)
    end
  end
end
