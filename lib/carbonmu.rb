require "carbonmu/configuration"
require "carbonmu/version"
require "carbonmu/edge_router/edge_router"
require "carbonmu/server"
require 'dcell'
require 'dcell/registries/redis_adapter'

module CarbonMU
  class << self
    attr_accessor :configuration
    attr_accessor :server
  end
  self.configuration = Configuration.new

  def self.configure
    yield self.configuration
  end

  def self.start
    start_edge_router
    start_server
    sleep
  end

  def self.configure_dcell_node
    unless DCell.me
      registry = DCell::Registry::RedisAdapter.new(server: 'localhost')
      DCell.start(id: Socket.gethostname)
    end
  end

  def self.start_edge_router
    configure_dcell_node
    EdgeRouter.supervise_as :edge_router, "0.0.0.0", 8421
  end

  def self.start_server
    configure_dcell_node
    Server.supervise_as :server
  end
end

