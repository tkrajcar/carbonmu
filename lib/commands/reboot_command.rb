module CarbonMU
  class RebootCommand < Command
    command do
      Reboot.reboot
    end
  end
end
