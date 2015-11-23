require 'fileutils'

module CarbonMU
  class CLI
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def execute
      if @argv.length == 0 || !COMMAND_WHITELIST.include?(@argv[0])
        puts USAGE
        exit(1)
      end

      command = @argv.shift
      send(command, *@argv)
    end

    def start
      CarbonMU.start
    end

    def create(game_name)
      FileUtils.mkdir_p("#{game_name}/config")
      gemfile = <<-GEMFILE
source 'https://rubygems.org'

gem 'carbonmu', '~> #{CarbonMU::VERSION}'
      GEMFILE
      database = <<-DATABASE
production:
  sessions:
    default:
      hosts:
        - localhost
      database: #{game_name}
DATABASE

      File.write("#{game_name}/Gemfile", gemfile)
      File.write("#{game_name}/config/database.yml", database)

      FileUtils.chdir(game_name) do
        Bundler.with_clean_env do
          Kernel.system("bundle install")
        end
      end
    end

    COMMAND_WHITELIST = ["start", "create"]

    USAGE = <<-USAGE
Usage: carbonmu start
USAGE
  end
end
