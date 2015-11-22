module Helpers
  def stub_carbonmu_server
    server = mock("Server")
    CarbonMU.stubs(:server).returns(server)
    server
  end
end
