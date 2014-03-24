require 'celluloid/autostart'
require 'celluloid/io'
require 'json'

module CarbonMU
  class Overlord
    include Celluloid::IO
    include Celluloid::Logger
    #finalizer :shutdown

    attr_reader :receptors, :connections, :overlord_ipc_server, :ipc_socket, :server_pid

    def initialize(host, port)
      info "*** Starting CarbonMU overlord."
      @receptors = TelnetReceptor.new(host,port)
      @connections = []
      @overlord_ipc_server = TCPServer.new(host, 10019)
      async.run
      start_server
    end

    def start_server
      @server_pid = spawn("/usr/bin/env ruby start-server-only")
      Process.detach(@server_pid)
      info "Server PID: #{@server_pid}."
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
    end

    def run
      loop { async.handle_connection @overlord_ipc_server.accept }
    end

    def handle_connection(socket)
      @ipc_socket = socket
      loop do
        data = socket.readpartial(4096)
        handle_server_datagram(data)
      end
    end

    def send_connect_to_server(connection)
      send_hash_to_server({op: 'connect', connection_id: connection.id})
    end

    def send_disconnect_to_server(connection)
      send_hash_to_server({op: 'disconnect', connection_id: connection.id})
    end

    def send_command_to_server(input, connection_id)
      send_hash_to_server({op: 'cmd', connection_id: connection_id, cmd: input})
    end

    def send_hash_to_server(hash)
      datagram = JSON.generate(hash)
      info "OVERLORD SEND: #{datagram}"
      @ipc_socket.write(datagram)
    end

    def handle_server_datagram(input)
      datagram = JSON.parse(input)
      info "OVERLORD RECEIVE: #{datagram}"
      case datagram['op']
      when 'write'
        conn = @connections.select {|x| x.id == datagram['connection_id']}.first # TODO look for efficiency here
        conn.write(datagram['output'])
      else
        raise ArgumentError, "Unsupported operation '#{datagram['op']}' received from Server."
      end
    end
  end
end
