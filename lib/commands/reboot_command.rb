module CarbonMU
  class RebootCommand < Command
    syntax "reboot"

    def execute
      Notify.all("SERVER: ".white.on_red + "Rebooting, please wait...")
      Server.trigger_reboot
    end
  end
end
