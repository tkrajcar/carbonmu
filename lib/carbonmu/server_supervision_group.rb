require "carbonmu/server"

module CarbonMU
  class ServerSupervisionGroup < Celluloid::SupervisionGroup
    supervise Server, as: :server
  end
end
