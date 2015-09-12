require "carbonmu/edge_router/telnet_receptor"

module CarbonMU
  class EdgeRouter
    include Celluloid
    include Celluloid::Logger

    finalizer :shutdown

    attr_reader :receptors, :connections

    def initialize(host, port)
      info "*** Starting CarbonMU edge router."

      @receptors = TelnetReceptor.new(host,port)
      @connections = []
    end

    def server
      Actor[:server].async
    end

    def add_connection(connection)
      @connections << connection
      server.add_connection(connection.id)
    end

    def remove_connection(connection)
      @connections.delete(connection)
      server.remove_connection(connection.id)
    end

    def shutdown
      # TODO Tell all receptors and connections to quit.
      #Process.kill("TERM", @current_server_pid) if @current_server_pid
    end

    def send_command_to_server(input, connection_id)
      server.handle_command(input, connection_id)
    end

    def reboot_server
      warn "Reboot triggered!"
      Process.kill("TERM", @current_server_pid)
      start_server
    end

    def write(connection_id, message)
      conn = @connections.find {|x| x.id == connection_id} # TODO look for efficiency here
      conn.write(message + "\n")
    end

#    def handle_server_message(input)
#      when :reboot
#        reboot_server
#      when :quit
#        conn = @connections.find {|x| x.id == message.connection_id} # TODO look for efficiency here
#        conn.shutdown
#      when :retrieve_existing_connections
#        info 'Sending connections to server...'
#        @connections.each do |conn|
#          send_connect_to_server(conn)
#        end
  end
end
