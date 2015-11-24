require 'minitest/autorun'
require "minitest/reporters"
require "mocha/mini_test"

require 'mongoid'
require 'database_cleaner'

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

require File.expand_path '../../lib/carbonmu.rb', __FILE__

include CarbonMU

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

Mongoid.logger.level = ::Logger::DEBUG
Mongoid.load!("config/database.yml", ENV["MONGOID_ENV"] || :production)

DatabaseCleaner.strategy = :truncation
