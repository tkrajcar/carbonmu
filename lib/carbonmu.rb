require "carbonmu/configuration"
require "carbonmu/version"
require "carbonmu/edge_router/edge_router_supervision_group"
require "carbonmu/server_supervision_group"

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
    EdgeRouterSupervisionGroup.run
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

