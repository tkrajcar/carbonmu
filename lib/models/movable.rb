module CarbonMU
  class Movable < Tangible
    include Mongoid::Document

    belongs_to :location, class_name: "CarbonMU::Tangible", inverse_of: :contents, index: true

    validates_presence_of :location
  end
end
