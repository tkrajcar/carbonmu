module CarbonMU
  class RebootCommand
    c = Command.new(prefix: :reboot) do
      Reboot.reboot
    end
    CommandManager.add(c)
  end
end
