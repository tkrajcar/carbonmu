require_relative "../test_helper.rb"

class ConfigurationTest < Minitest::Test
  def setup
    @config = Configuration.new
  end

  def test_maintains_global_configuration
    mock_config = Struct.new(:test_setting).new
    CarbonMU.configuration = mock_config
    setting = mock("Setting")

    CarbonMU.configure do |config|
      config.test_setting = setting
    end

    assert_equal CarbonMU.configuration.test_setting, setting
  end

  def test_creates_a_logger
    assert_kind_of Logger, @config.logger
  end

  def test_doesnt_allow_an_invalid_logger
    assert_raises(ArgumentError) do
      @config.logger = Object.new
    end
  end
end
