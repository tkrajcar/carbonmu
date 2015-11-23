require "celluloid/io"
require "carbonmu/edge_router/telnet_connection"

module CarbonMU
  class TelnetReceptor
    include Celluloid::IO
    include Celluloid::Logger

    finalizer :shutdown

    attr_reader :connections

    def initialize(host, port)
      info "*** Starting Telnet receptor on #{host} #{port}."
      @server = Celluloid::IO::TCPServer.new(host, port)
      @connections = []
      async.run
    end

    def shutdown
      @server.close if @server
    end

    def run
      loop { async.handle_connection @server.accept }
    end

    def handle_connection(socket)
      @connections << TelnetConnection.new(socket)
    end
  end
end
