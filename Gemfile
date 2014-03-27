source 'https://rubygems.org/'

gem "celluloid-io", "~> 0.15.0"
gem "require_all"
gem "multi_json", "~> 1.9.2"
gem "oj", "~> 2.6.1", platforms: [:ruby]
gem "celluloid-zmq", github: 'celluloid/celluloid-zmq', ref: '4c2ab1af7b757ab7b5f4758afe09743c141c46ea' # add Socket#get

group :development do
  gem "awesome_print"
  gem "pry"
  gem "rake"
end

group :development, :test do
  gem "rspec"
end

group :test do
  gem "codeclimate-test-reporter", require: nil
end
