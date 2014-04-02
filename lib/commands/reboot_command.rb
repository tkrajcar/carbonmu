module CarbonMU
  class RebootCommand
    CommandManager.add :reboot do
      Reboot.reboot
    end
  end
end
