module CarbonMU
  class Tangible
    include Mongoid::Document

    field :name, type: String
    field :description, type: String
    field :_special, type: Symbol

    index(_special: 1)

    validates_uniqueness_of :_special, allow_blank: true
    has_many :contents, class_name: "CarbonMU::Movable", foreign_key: :location
  end
end
