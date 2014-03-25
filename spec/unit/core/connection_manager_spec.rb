require 'spec_helper'

describe ConnectionManager do
  before(:each) do
    @connection = double("Connection", id: SecureRandom.uuid)
    @other_connection = double("Connection", id: SecureRandom.uuid)
  end

  after(:each) do
    ConnectionManager.remove_all
  end

  context "#add and accessors" do
    it "adds a connection and supports retrieving by array" do
      ConnectionManager.add @connection
      ConnectionManager.connections.should eq([@connection])
    end

    it "adds a connection and supports id-based access" do
      ConnectionManager.add @connection
      ConnectionManager[@connection.id].should eq(@connection)
    end
  end

  context "#remove" do
    it "removes a connection" do
      ConnectionManager.add @connection
      ConnectionManager.add @other_connection
      expect {ConnectionManager.remove @other_connection}.to change{ConnectionManager.connections.count}.by(-1)
    end
  end

  context "#remove_by_id" do
    it "removes by id" do
      ConnectionManager.add @connection
      ConnectionManager.add @other_connection
      ConnectionManager.remove_by_id @other_connection.id
      ConnectionManager.connections.should eq([@connection])
    end
  end

  context "#remove_all" do
    it "removes all" do
      ConnectionManager.add @connection
      ConnectionManager.remove_all
      ConnectionManager.connections.should eq([])
    end
  end
end