require 'rubygems'
require 'bundler'
Bundler.setup(:default)

require 'require_all'
require_all 'lib'

module CarbonMU
  def self.start
    Server.new 'localhost', 8421
    loop { }
  end
end
