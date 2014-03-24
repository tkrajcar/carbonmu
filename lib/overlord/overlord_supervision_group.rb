module CarbonMU
  class OverlordSupervisionGroup < Celluloid::SupervisionGroup
    supervise Overlord, as: :overlord, args: ["localhost", 8421]
  end
end
