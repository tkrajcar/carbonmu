module Helpers
  def stub_carbonmu_server
    server = double("Server")
    allow(CarbonMU).to receive(:server) { server }
    server
  end

  def command_parse_results(raw_command)
    Parser.parse(raw_command)
  end

  def parse_to(klass, params={})
    [klass, params]
  end
end
