require 'rubygems'
require 'bundler/setup'

require 'require_all'
require_all 'lib'

module CarbonMU
  class << self
    attr_accessor :configuration
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
end

