require 'rubygems'
require 'bundler/setup'

require 'require_all'
require_all '.'

module CarbonMU
  s = Server.new 'localhost', 8421
  loop { }
end