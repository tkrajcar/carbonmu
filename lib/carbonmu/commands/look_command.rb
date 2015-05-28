module CarbonMU
  class LookCommand < Command
    syntax "look"

    def execute
      notify_location_name
      notify_location_description
      notify_contents
      # exits if exits
    end

    def notify_location_name
      CarbonMU.server.notify_player(@player, "location.name", {message: @player.location.name})
    end

    def notify_location_description
      CarbonMU.server.notify_player(@player, "location.description", {message: @player.location.description})
    end

    def notify_contents
      CarbonMU.server.notify_player(@player, "location.contents", {message: @player.location.contents.map(&:name).compact.join(',')})
    end
  end
end
