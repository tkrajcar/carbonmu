module CarbonMU
  class SupervisionGroup < Celluloid::SupervisionGroup
    supervise Server, as: :server, args: ["localhost", 8421]
  end
end
