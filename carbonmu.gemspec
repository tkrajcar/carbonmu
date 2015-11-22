# -*- encoding: utf-8 -*-
$:.push('lib')
require "carbonmu/version"

Gem::Specification.new do |s|
  s.name     = "carbonmu"
  s.version  = CarbonMU::VERSION.dup
  s.required_ruby_version = ">= 2.0.0"
  s.date     = Time.now.strftime('%Y-%m-%d')
  s.summary  = "CarbonMU is a general-purpose, extendable MUD/MUSH server written in Ruby."
  s.email    = "allegro@conmolto.org"
  s.homepage = "http://github.com/tkrajcar/carbonmu"
  s.authors  = ['Tim Krajcar']
  s.licenses = ['MIT']

  s.description = <<-EOF
CarbonMU is a general-purpose, extendable MUD/MUSH server written in Ruby. CarbonMU is still
under active development and not yet ready for general use.
EOF
  s.add_dependency "dcell", "~> 0.16.1"

  s.add_dependency "multi_json", "~> 1.9.2"
  s.add_dependency "colorize", "~> 0.7.3"
  s.add_dependency "mongoid", "~> 4.0.2"
  s.add_dependency "i18n", "~> 0.7.0"
  s.add_dependency "bcrypt", "~> 3.1.10"

  s.add_development_dependency "awesome_print"
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
  s.add_development_dependency "guard", "~> 2.12.4"
  s.add_development_dependency "minitest", "~> 5.8.3"
  s.add_development_dependency "minitest-reporters"
  s.add_development_dependency "mocha", "~> 1.1.0"

  s.add_development_dependency "guard"
  s.add_development_dependency "guard-minitest"

  s.add_development_dependency "database_cleaner", "~> 1.3.0"
  s.add_development_dependency "i18n-tasks", "~> 0.7.12"
  s.add_development_dependency "fakefs", "~> 0.6.7"

  s.files         = `git ls-files`.split
  s.test_files    = Dir['spec/**/*']
  s.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  ## Make sure you can build the s.add_dependency on older versions of RubyGems too:
  s.rubygems_version = "2.2.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.specification_version = 3 if s.respond_to? :specification_version
end
