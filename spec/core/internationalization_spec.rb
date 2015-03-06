require "spec_helper"

describe Internationalization do
  context ".setup" do
    it "loads the right loadpath" do
      # TODO fixy
      CarbonMU::Internationalization.setup
      expect(I18n.load_path).to eq(["config/locales/en.yml", "config/locales/nl.yml"])
    end
  end

  context ".translate" do
    it "calls I18n.t" do
      str = "foo"
      opts = {foo: "bar"}
      expect(I18n).to receive(:t).with(str, [opts])
      CarbonMU::Internationalization.translate(str, opts)
    end
  end
end
