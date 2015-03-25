module CarbonMU
  class GameObject
    include Mongoid::Document

    field :name, type: String
    field :description, type: String, default: "You see nothing special."
    field :_special, type: Symbol

    index(_special: 1)

    validates_uniqueness_of :_special, allow_blank: true
  end
end
