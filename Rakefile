require 'carbonmu/version'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

task :default => :test

desc "Launch console"
task :console do
  require 'carbonmu'
  require 'awesome_print'
  require 'pry'
  CarbonMU::Server.initialize_database
#  CarbonMU::Server.create_starter_objects
  Pry.start CarbonMU
end

namespace :gem do
  desc "Build new gem."
  task :build do
    system "gem build carbonmu.gemspec"
  end

  desc "Release new gem."
  task :release => :build do
    system "gem push carbonmu-#{CarbonMU::VERSION}.gem"
    system "git tag #{CarbonMU::VERSION}"
    puts "Don't forget to `git push --tags`."
  end
end
