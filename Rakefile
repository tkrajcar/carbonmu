require 'carbonmu/version'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.description = "Run i18n-specific missing/unused translation key tests"
  t.pattern = "test/i18n_keys_specialtest.rb"
  t.verbose = true
  t.name = "test:i18n"
end

task :default => :test

desc "Launch console"
task :console do
  require 'carbonmu'
  require 'awesome_print'
  require 'pry'
  CarbonMU.start_server
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
