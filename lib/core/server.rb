require 'celluloid/autostart'
require 'celluloid/io'

module CarbonMU
  class Server
    include Celluloid::IO
    include Celluloid::Logger
    finalizer :shutdown

    def initialize(host, port)
      info "*** Starting server on #{host}:#{port}"

      # Since we included Celluloid::IO, we're actually making a
      # Celluloid::IO::TCPServer here
      @server = TCPServer.new(host, port)
      async.run
    end

    def shutdown
      @server.close if @server
    end

    def run
      loop { async.handle_connection @server.accept }
    end

    def handle_connection(socket)
      c = ConnectionManager.add(socket)
      c.async.run
    end
  end
end
