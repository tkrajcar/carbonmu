require_relative './movable.rb'

module CarbonMU
  class Room < Tangible
    include Mongoid::Document

    has_many :incoming_exits, class_name: "CarbonMU::Exit", foreign_key: :destination

    def self.starting
      find_by(_special: :starting_room)
    end

    def self.lostandfound
      find_by(_special: :lostandfound_room)
    end
  end
end
