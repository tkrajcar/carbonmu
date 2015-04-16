require 'spec_helper'
require 'carbonmu/cli'
require 'fakefs/spec_helpers'

RSpec.describe CLI do
  context "#new" do
    include FakeFS::SpecHelpers

    let(:cli) { CLI.new([]) }
    let(:name) { 'mygame' }

    before(:each) do
      allow(Kernel).to receive(:system).with("bundle install")
    end

    it "creates a directory named after its argument" do
      cli.create(name)
      expect(File.directory?(name)).to be true
    end

    it "creates a config directory inside the named directory" do
      cli.create(name)
      expect(File.directory?("#{name}/config")).to be true
    end

    it "puts a gemfile in the new directory" do
      cli.create(name)
      expect(File.exists?("#{name}/Gemfile")).to be true
    end

    it "includes carbonmu in the gemfile" do
      cli.create(name)
      expect(File.read("#{name}/Gemfile")).to include 'carbonmu'
    end

    it "includes the current carbonmu version in the gemfile" do
      cli.create(name)
      expect(File.read("#{name}/Gemfile")).to include CarbonMU::VERSION
    end

    it "puts a database.yml file in the new directory" do
      cli.create(name)
      expect(File.exists?("#{name}/config/database.yml")).to be true
    end

    it "names the database after the game" do
      cli.create(name)
      expect(File.read("#{name}/config/database.yml")).to include name
    end

    it "changes into the game directory" do
      expect(FileUtils).to receive(:chdir).with(name)
      cli.create(name)
    end

    it "bundles everyday b..b..b..bundles everyday" do
      expect(Kernel).to receive(:system).with('bundle install')
      cli.create(name)
    end
  end
end
