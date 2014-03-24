require 'json'

module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger

    attr_reader :overlord

    def initialize
      info "*** Starting CarbonMU game server."
      @overlord = TCPSocket.new('localhost', 10019)
      # TODO talk to Overlord to retrieve any already-open connections.
      async.run
    end

    def run
      loop do
        input = @overlord.readpartial(4096)
        handle_overlord_datagram(input)
      end
    end

    def add_connection(connection_id)
      new_conn = ServerConnection.new(connection_id, Actor.current)
      ConnectionManager.add(new_conn)
    end

    def remove_connection(connection_id)
      ConnectionManager.remove_by_id(connection_id)
    end

    def connections
      ConnectionManager.connections
    end

    def handle_command(input, connection_id)
      context = CommandContext.new(enacting_connection_id: connection_id, command: input)
      Parser.parse(context)
    end

    def handle_overlord_datagram(input)
      parsed = JSON.parse(input)
      info "SERVER RECEIVE: #{parsed}"
      case parsed['op']
      when 'cmd'
        handle_command(parsed['cmd'], parsed['connection_id'])
      when 'connect'
        add_connection(parsed['connection_id'])
      when 'disconnect'
        remove_connection(parsed['connection_id'])
      else
        raise ArgumentError, "Unsupported operation '#{parsed['op']}' received from Overlord."
      end
    end

    def write_to_connection(connection_id, str)
      datagram = {op: "write", connection_id: connection_id, output: str}
      info "SERVER SEND: #{datagram}"
      @overlord.write(JSON.generate(datagram))
    end
  end
end
