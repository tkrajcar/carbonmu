module Helpers
  def stub_carbonmu_server
    server = double("Server")
    CarbonMU.stub(:server) { server }
    server
  end
end
