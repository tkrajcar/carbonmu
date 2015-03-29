require "spec_helper"

describe Internationalization do

  context ".setup" do
    it "loads the core locale files" do
      CarbonMU::Internationalization.setup
      core_locales_dir = File.expand_path("../../../../config/locales", __FILE__)

      expect(I18n.load_path).to include("#{core_locales_dir}/en.yml")
    end
  end

  context ".t" do
    it "calls I18n.t" do
      str = "foo"
      opts = {foo: "bar"}
      expect(I18n).to receive(:t).with(str, opts)
      CarbonMU::Internationalization.t(str, opts)
    end
  end
end
