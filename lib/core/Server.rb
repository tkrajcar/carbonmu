require 'celluloid/autostart'
require 'celluloid/io'

module CarbonMU
  class Server
    include Celluloid::IO
    finalizer :shutdown

    attr_reader :sockets

    def initialize(host, port)
      puts "*** Starting server on #{host}:#{port}"

      # Since we included Celluloid::IO, we're actually making a
      # Celluloid::IO::TCPServer here
      @server = TCPServer.new(host, port)
      @sockets  = []
      async.run
    end

    def shutdown
      @server.close if @server
    end

    def run
      loop { async.handle_connection @server.accept }
    end

    def handle_connection(socket)
      _, port, host = socket.peeraddr
      puts "*** Received connection from #{host}:#{port}"
      @sockets << socket
      loop do
        buf = socket.readpartial(4096)
        @sockets.each do |s|
          s.write "#{socket.addr[2]} said: #{buf}"
        end
      end
    rescue EOFError
      puts "*** #{host}:#{port} disconnected"
      socket.close
      @sockets.delete(socket)
    end
  end
end