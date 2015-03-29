module CarbonMU
  class RebootCommand < Command
    syntax "reboot"

    def execute
      CarbonMU.server.notify_all_players_raw("SERVER: ".white.on_red + "Rebooting, please wait...")
      Server.trigger_reboot
    end
  end
end
