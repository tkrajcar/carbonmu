module CarbonMU
  class Exit < Movable
    include Mongoid::Document

    belongs_to :destination, class_name: "CarbonMU::Exit", inverse_of: :incoming_exits, index: true

  end
end
