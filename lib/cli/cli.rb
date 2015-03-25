module CarbonMU
  class CLI
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def execute
      if @argv.length == 0 || !COMMAND_WHITELIST.include?(@argv[0])
        puts USAGE
        exit(1)
      end

      command = @argv.shift
      send(command, *@argv)
    end

    def start
      CarbonMU.start
    end

    def start_server_only(port)
      CarbonMU.edge_router_receive_port = port
      CarbonMU.start_server
    end

    COMMAND_WHITELIST = ["start", "start_server_only"]

    USAGE = <<-USAGE
Usage: carbonmu start
USAGE
  end
end
