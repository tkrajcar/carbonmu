module CarbonMU
  class Thing < GameObject
    include Mongoid::Document
    include Movable
    include Container
  end
end
