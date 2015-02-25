module CarbonMU
  module Parser
    def self.parse(enacting_connection_id, input)
      match_data = nil
      syntax_and_class = @@syntaxes.detect do |syntax, klass|
        match_data = syntax.match(input)
      end

      matching_syntax, matching_class = syntax_and_class

      if matching_class
        context = CommandContext.new(enacting_connection_id: enacting_connection_id, raw_command: input, params: match_data.to_hash)
        matching_class.new(context).execute
      else
        # TODO handle a bad command
        Notify.all("bad command #{input}")
      end
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
