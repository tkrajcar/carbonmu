module CarbonMU
  class Reboot
    def self.reboot
      Notify.all("SERVER: ".white.on_red + "Rebooting, please wait...")
      Server.trigger_reboot
    end
  end
end
