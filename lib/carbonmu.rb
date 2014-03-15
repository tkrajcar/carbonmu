require 'rubygems'
require 'bundler/setup'

require 'require_all'
require_all '.'

module CarbonMU
  Server.new 'localhost', 8421
  loop { }
end