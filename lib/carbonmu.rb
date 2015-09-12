require "carbonmu/configuration"
require "carbonmu/version"
require "carbonmu/edge_router/edge_router"
require 'dcell'
require 'dcell/registries/redis_adapter'

registry = DCell::Registry::RedisAdapter.new :server => 'localhost'

DCell.start :id => "boo", :addr => "tcp://127.0.0.1:9001", :registry => registry


module CarbonMU
  class << self
    attr_accessor :configuration
    attr_accessor :edge_router_receive_port
    attr_accessor :server
  end
  self.configuration = Configuration.new

  def self.configure
    yield self.configuration
  end

  def self.start
    EdgeRouter.supervise_as :edge_router, "0.0.0.0", 8421
    sleep
  end

  def self.start_in_background
    EdgeRouterSupervisionGroup.run!
  end

  def self.start_server
    ServerSupervisionGroup.run
  end

  def self.start_server_in_background
    ServerSupervisionGroup.run!
  end
end

