module Helpers
  def stub_carbonmu_server
    server = double("Server")
    allow(CarbonMU).to receive(:server) { server }
    server
  end

  def command_parse_results(raw_command)
    Parser.new.parse(raw_command)
  end

  def parse_to(klass, params={})
    [klass, params]
  end

  def run_command(klass, params = {})
    c = Connection.new(1)
    cc = CommandContext.new({connection: c, params: params})
    klass.new(cc).execute
  end

  def run_command_with_player(klass, player, params={})
    c = Connection.new(1)
    c.player = player
    cc = CommandContext.new({connection: c, params: params})
    klass.new(cc).execute
  end
end

