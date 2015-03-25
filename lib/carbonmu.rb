require 'rubygems'
require 'bundler/setup'

require 'require_all'
require 'colorize' # An exception to our require-where-used rule, since it's likely to be used many places.
require_all File.dirname(__FILE__)

Celluloid::ZMQ.init

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

  def self.t(str, *opts)
    CarbonMU::Internationalization.translate(str, opts)
  end
end

