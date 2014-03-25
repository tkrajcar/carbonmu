require 'celluloid/autostart'
require 'celluloid/io'

module CarbonMU
  class TelnetReceptor
    include Celluloid::IO
    include Celluloid::Logger

    finalizer :shutdown

    def initialize(host, port)
      info "*** Starting Telnet receptor on #{host} #{port}."
      @server = Celluloid::IO::TCPServer.new(host, port)
      async.run
    end

    def shutdown
      @server.close if @server
    end

    def run
      loop { async.handle_connection @server.accept }
    end

    def handle_connection(socket)
      tc = TelnetConnection.new(socket)
      Actor[:overlord].add_connection(tc)
    end
  end
end
