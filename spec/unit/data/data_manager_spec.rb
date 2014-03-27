require 'spec_helper'

describe DataManager do
  context ".persist" do
    before(:each) do
      @fake_engine = double("DataEngine", persist: true).as_null_object
      Celluloid::Actor.stub(:[]).with(:data_engine) { @fake_engine }
      @fake_obj = double("PersistableObject")
    end

    it "passes .persist on to the data engine with a duplicate object" do
      @fake_engine.should_receive(:persist).with(an_instance_of(@fake_obj.class))
      DataManager.persist(@fake_obj)
    end

    it "it doesn't attempt to pass the data engine the exact object received" do
      @fake_engine.should_not_receive(:persist).with(@fake_obj)
      DataManager.persist(@fake_obj)
    end
  end
end