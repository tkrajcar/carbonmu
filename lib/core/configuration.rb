require 'celluloid'
require 'logger'

module CarbonMU
  class Configuration
    attr_accessor :game_name
    attr_reader :logger
    attr_accessor :log_ipc_traffic

    def initialize
      @game_name = 'CarbonMU'
      @logger = Celluloid.logger.tap { |i| i.progname = @game_name }
      @log_ipc_traffic = false
    end

    def logger=(logger)
      raise ArgumentError.new("Not a logger: #{logger}") unless logger.is_a?(Logger)
      Celluloid.logger = logger
      @logger = logger
    end
  end
end
