require "carbonmu/edge_router/telnet_receptor"

module CarbonMU
  class EdgeRouter
    include Celluloid
    include Celluloid::Logger

    # finalizer :shutdown TODO

    attr_reader :receptors
    attr_reader :connected_players

    def initialize
      info "*** Starting CarbonMU edge router."

      @receptors = []
      @receptors << TelnetReceptor.new("0.0.0.0", 8421)
      @connected_players = Hash.new([])
    end

    def shutdown
      # TODO Tell all receptors to quit, and kill serevr.
      #Process.kill("TERM", @current_server_pid) if @current_server_pid
    end

    def reboot_server
      warn "Reboot triggered!"
      Process.kill("TERM", @current_server_pid)
      start_server
    end

    def connections_for_player(player_id)
      @connected_players[player_id]
    end
  end
end
