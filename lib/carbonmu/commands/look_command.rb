module CarbonMU
  class LookCommand < Command
    syntax "look"

    def execute
      notify_location_name
      notify_location_description
      # contents if contents
      # exits if exits
    end

    def notify_location_name
      CarbonMU.server.notify_player(@player, "emits.location_name", {message: @player.location.name})
    end

    def notify_location_description
      CarbonMU.server.notify_player(@player, "emits.location_description", {message: @player.location.description})
    end
  end
end
