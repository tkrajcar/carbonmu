module CarbonMU
  class RebootCommand < Command
    syntax "reboot"

    def execute
      Reboot.reboot
    end
  end
end
