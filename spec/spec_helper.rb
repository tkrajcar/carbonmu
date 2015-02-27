# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'bundler'
require 'timecop'
Bundler.setup(:default, :test)

require_relative '../lib/carbonmu.rb'
require 'pry'

include CarbonMU
CarbonMU.configure do |c|
  c.logger = Logger.new(nil)
end

# custom matchers
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.run_all_when_everything_filtered = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  config.include Helpers
end
