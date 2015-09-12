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

    def start_server
      server_pid = spawn("bundle exec carbonmu start_server_only 1")
      Process.detach(server_pid)
    end

    def add_connection(connection)
      @connections << connection
      send_connect_to_server(connection)
    end

    def remove_connection(connection)
      @connections.delete(connection)
      send_disconnect_to_server(connection)
    end

    def shutdown
      # TODO Tell all receptors and connections to quit.
      #Process.kill("TERM", @current_server_pid) if @current_server_pid
    end


    def send_connect_to_server(connection)
      send_message_to_server(:connect, connection_id: connection.id)
    end

    def send_disconnect_to_server(connection)
      send_message_to_server(:disconnect, connection_id: connection.id)
    end

    def send_command_to_server(input, connection_id)
      send_message_to_server(:command, command: input, connection_id: connection_id)
    end

    def send_message_to_server(op, params={})
      message = IPCMessage.new(op, params)
      debug "EDGE ROUTER SEND: #{message}" if CarbonMU.configuration.log_ipc_traffic
      @ipc_writer.send message.serialize
    end

    def reboot_server
      warn "Reboot triggered!"
      Process.kill("TERM", @current_server_pid)
      start_server
    end

    def handle_server_message(input)
      message = IPCMessage.unserialize(input)
      debug "EDGE ROUTER RECEIVE: #{message}" if CarbonMU.configuration.log_ipc_traffic
      case message.op
      when :started
        handle_server_started(message.pid, message.port)
      when :write
        conn = @connections.find {|x| x.id == message.connection_id} # TODO look for efficiency here
        conn.write(message.output + "\n")
      when :reboot
        reboot_server
      when :quit
        conn = @connections.find {|x| x.id == message.connection_id} # TODO look for efficiency here
        conn.shutdown
      when :retrieve_existing_connections
        info 'Sending connections to server...'
        @connections.each do |conn|
          send_connect_to_server(conn)
        end
      else
        raise ArgumentError, "Unsupported operation '#{message.op}' received from Server."
      end
    end
  end
end
