require 'celluloid/autostart'
require 'celluloid/io'

module CarbonMU
  class Overlord
    include Celluloid::IO
    include Celluloid::Logger
    #finalizer :shutdown

    attr_reader :receptors

    def initialize(host, port)
      info "*** Starting CarbonMU overlord."
      @receptors = TelnetReceptor.new(host,port)
    end

    def shutdown
      # TODO Tell all receptors to quit.
    end

    def run
      # TODO needed?
      #loop { async.handle_connection @server.accept }
    end

    def handle_connection(socket)
      # TODO needed?
      #c = ConnectionManager.add(socket)
      #c.async.run
    end
  end
end
