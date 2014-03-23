module CarbonMU
  class RebootCommand < Command
    command do
      Server.reboot
    end
  end
end
