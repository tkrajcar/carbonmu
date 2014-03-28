require 'rubygems'
require 'bundler/setup'

require 'require_all'
require_all 'lib'

Celluloid::ZMQ.init

module CarbonMU
  class << self
    attr_accessor :configuration
    attr_accessor :overlord_receive_port
  end
  self.configuration = Configuration.new

  def self.configure
    yield self.configuration
  end

  def self.start
    OverlordSupervisionGroup.run
  end

  def self.start_in_background
    OverlordSupervisionGroup.run!
  end

  def self.start_server
    ServerSupervisionGroup.run
  end

  def self.start_server_in_background
    ServerSupervisionGroup.run!
  end
end

