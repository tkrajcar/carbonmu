module CarbonMU
  class SupervisionGroup < Celluloid::SupervisionGroup
    supervise Overlord, as: :overlord, args: ["localhost", 8421]
    supervise Server, as: :server
  end
end
