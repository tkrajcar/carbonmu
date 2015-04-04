require 'celluloid/autostart'
require 'celluloid/io'
require 'celluloid/zmq'
require "carbonmu/edge_router/telnet_receptor"
require "carbonmu/ipc/read_socket"
require "carbonmu/ipc/write_socket"

module CarbonMU
  class EdgeRouter
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    finalizer :shutdown

    attr_reader :receptors, :connections

    def initialize(host, port)
      info "*** Starting CarbonMU edge router."
      @receptors = TelnetReceptor.new(host,port)
      @connections = []

      @ipc_reader = ReadSocket.new
      info "*** Edge router waiting for IPC on port #{@ipc_reader.port_number}"
      async.run

      start_server
    end

    def start_server
      spawn("bundle exec carbonmu start_server_only #{@ipc_reader.port_number}")
    end

    def handle_server_started(pid, port)
      debug "*** Edge router received server IPC start. Pid #{pid}, port #{port}." if CarbonMU.configuration.log_ipc_traffic
      @current_server_pid = pid
      Process.detach(pid)
      @ipc_writer = WriteSocket.new(port)
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
      Process.kill("TERM", @current_server_pid)
    end

    def run
      loop do
        async.handle_server_message(@ipc_reader.read)
      end
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
