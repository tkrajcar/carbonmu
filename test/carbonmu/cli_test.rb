require_relative "../test_helper.rb"
require 'carbonmu/cli'
require 'fakefs/safe'

class CLITest < Minitest::Test
  def setup
    @cli = CLI.new([])
    @name = "mygame"
    Kernel.stubs(:system).with("bundle install")
  end

  def test_creates_a_directory
    FakeFS do
      @cli.create(@name)
      assert File.directory?(@name)
    end
  end

  def test_creates_a_config_directory
    FakeFS do
      @cli.create(@name)
      assert File.directory?("#{@name}/config")
    end
  end

  def test_gemfile_includes_carbonmu_current_version
    FakeFS do
      @cli.create(@name)
      assert_includes File.read("#{@name}/Gemfile"), 'carbonmu'
      assert_includes File.read("#{@name}/Gemfile"), CarbonMU::VERSION
    end
  end

  def test_database_yml_includes_database_named_after_game
    FakeFS do
      @cli.create(@name)
      assert_includes File.read("#{@name}/config/database.yml"), @name
    end
  end

  def test_bundles_every_day_b_b_b_bundles_every_day
    FakeFS do
      Kernel.expects(:system).with('bundle install')
      @cli.create(@name)
    end
  end
end
