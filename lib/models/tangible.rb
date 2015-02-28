module CarbonMU
  class Tangible
    include Mongoid::Document

    field :name, type: String
    field :description, type: String

    has_many :contents, class_name: "CarbonMU::Movable", foreign_key: :location
  end
end
