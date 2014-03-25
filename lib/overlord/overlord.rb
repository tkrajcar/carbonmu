require 'celluloid/autostart'
require 'celluloid/io'
require 'celluloid/zmq'
require 'json'

module CarbonMU
  class Overlord
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    finalizer :shutdown

    attr_reader :receptors, :connections, :zmq_out, :zmq_in, :server_pid

    def initialize(host, port)
      info "*** Starting CarbonMU overlord."
      @receptors = TelnetReceptor.new(host,port)
      @connections = []

      @zmq_out = PushSocket.new
      @zmq_out.bind("tcp://127.0.0.1:15000")

      @zmq_in = PullSocket.new
      @zmq_in.connect("tcp://127.0.0.1:15001")

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
      @zmq_out.close
      @zmq_in.close
      Process.kill("KILL", @server_pid)
    end

    def run
      loop do
        async.handle_server_datagram(@zmq_in.read)
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
      @zmq_out.send datagram
    end

    def reboot_server
      warn "Reboot triggered!"
      Process.kill("TERM", @server_pid)
      start_server
    end

    def handle_server_datagram(input)
      datagram = JSON.parse(input)
      info "OVERLORD RECEIVE: #{datagram}"
      case datagram['op']
      when 'write'
        conn = @connections.select {|x| x.id == datagram['connection_id']}.first # TODO look for efficiency here
        conn.write(datagram['output'])
      when 'reboot'
        reboot_server
      when 'retrieve_existing_connections'
        info 'Sending connections to server...'
        @connections.each do |conn|
          send_connect_to_server(conn)
        end
      else
        raise ArgumentError, "Unsupported operation '#{datagram['op']}' received from Server."
      end
    end
  end
end
