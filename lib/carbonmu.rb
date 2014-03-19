require 'rubygems'
require 'bundler/setup'

require 'require_all'
require_all 'lib'

module CarbonMU
  @@configuration = Configuration.new

  def self.configuration; @@configuration; end
  
  def self.configuration=(config); @@configuration = config; end

  def self.configure
    yield @@configuration
  end

  def self.start
    SupervisionGroup.run
  end

  def self.start_in_background
    SupervisionGroup.run!
  end
end

