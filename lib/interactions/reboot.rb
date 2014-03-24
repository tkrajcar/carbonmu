module CarbonMU
  class Reboot
    def self.reboot
      Notify.all("SERVER: Rebooting, please wait...")
      Server.trigger_reboot
    end
  end
end
