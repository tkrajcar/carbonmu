require 'celluloid/autostart'
require 'celluloid/io'

module CarbonMU
  class Overlord
    include Celluloid::IO
    include Celluloid::Logger
    #finalizer :shutdown

    attr_reader :receptors
    attr_reader :connections

    def initialize(host, port)
      info "*** Starting CarbonMU overlord."
      @receptors = TelnetReceptor.new(host,port)
      @connections = []
    end

    def add_connection(connection)
      @connections << connection
      Actor[:server].add_connection(connection)
    end

    def shutdown
      # TODO Tell all receptors to quit.
    end
  end
end
