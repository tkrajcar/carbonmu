module CarbonMU
  class ServerSupervisionGroup < Celluloid::SupervisionGroup
    supervise Server, as: :server, args: ["localhost", 10019]
  end
end
