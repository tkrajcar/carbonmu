require 'celluloid/autostart'
require 'celluloid/io'
require 'celluloid/zmq'
require 'multi_json'

module CarbonMU
  class Overlord
    include Celluloid::IO
    include Celluloid::Logger
    include Celluloid::ZMQ

    finalizer :shutdown

    attr_reader :receptors, :connections

    def initialize(host, port)
      info "*** Starting CarbonMU overlord."
      @receptors = TelnetReceptor.new(host,port)
      @connections = []

      @ipc_reader = ReadSocket.new
      info "*** Overlord waiting for IPC on port #{@ipc_reader.port_number}"
      async.run

      start_server
    end

    def start_server
      spawn("/usr/bin/env ruby start-server-only #{@ipc_reader.port_number}")
    end

    def handle_server_started(pid, port)
      info "*** Overlord received server IPC start. Pid #{pid}, port #{port}."
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
        async.handle_server_datagram(@ipc_reader.read)
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
      datagram = MultiJson.dump(hash)
      info "OVERLORD SEND: #{datagram}"
      @ipc_writer.send datagram
    end

    def reboot_server
      warn "Reboot triggered!"
      Process.kill("TERM", @current_server_pid)
      start_server
    end

    def handle_server_datagram(input)
      datagram = MultiJson.load(input)
      info "OVERLORD RECEIVE: #{datagram}"
      case datagram['op']
      when 'started'
        handle_server_started(datagram['pid'], datagram['port'])
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
