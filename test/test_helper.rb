require 'minitest/autorun'
require "minitest/reporters"
require "mocha/mini_test"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

require File.expand_path '../../lib/carbonmu.rb', __FILE__

include CarbonMU
