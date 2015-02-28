require_relative './movable.rb'

module CarbonMU
  class Room < Tangible
    include Mongoid::Document

    has_many :incoming_exits, class_name: "CarbonMU::Exit", foreign_key: :destination
  end
end
