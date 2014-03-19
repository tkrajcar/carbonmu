require 'spec_helper'

describe CarbonMU do
  describe 'global configuration' do
    it 'maintains app-wide configurations' do
      mock_config = Struct.new(:test_setting).new
      mock_setting = Object.new
      CarbonMU.configuration = mock_config

      CarbonMU.configure do |config|
        config.test_setting = mock_setting
      end

      expect(CarbonMU.configuration.test_setting).to be(mock_setting)
    end
  end
end

describe Configuration do
  let(:config) { Configuration.new }

  describe '#logger' do
    it 'has a logger' do
      expect(config.logger).to be_a(Logger)
    end

    it "doesn't allow an invalid logger" do
      expect { config.logger = Object.new }.to raise_error(ArgumentError) 
    end
  end
end
