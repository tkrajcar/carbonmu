module CarbonMU
  module Parser
    def self.parse_and_execute(enacting_connection_id, input)
      command_class, params = parse(input)

      context = CommandContext.new(enacting_connection_id: enacting_connection_id, raw_command: input, params: params)
      command_class.new(context).execute
    end

    def self.parse(input)
      syntax_match_data = {}
      syntax_and_class = @@syntaxes.detect { |syntax, klass| syntax_match_data = syntax.match(input) }

      command_class = syntax_and_class.nil? ? UnknownCommand : syntax_and_class[1]
      syntax_match_data ||= {} # if no syntaxes matched

      [command_class, syntax_match_data.to_hash]
    end

    def self.register_syntax(syntax, klass)
      @@syntaxes ||= {}
      @@syntaxes[syntax] = klass
    end

    def self.syntaxes
      @@syntaxes
    end
  end
end
