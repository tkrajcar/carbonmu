module CarbonMU
  class Player < Movable
    include Mongoid::Document

    def self.superadmin
      find_by(_special: :superadmin_player)
    end
  end
end
