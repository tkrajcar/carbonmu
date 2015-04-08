require "active_support/inflector"
require "carbonmu/command_context"
require "carbonmu/command"
require "core_ext/match_data"

Dir[File.dirname(__FILE__) + '/commands/*.rb'].each {|file| require file }

module CarbonMU
  class Parser
    attr_reader :syntaxes

    def initialize
      @syntaxes = {}
      Command.command_classes.each { |klass| register_command_class(klass) }
    end

    def parse_and_execute(connection, input)
      command_class, params = parse(input)

      context = CommandContext.new(connection: connection, raw_command: input, params: params)
      command_class.new(context).execute
    end

    def parse(input)
      syntax_match_data = {}
      syntax_and_class = @syntaxes.detect { |syntax, klass| syntax_match_data = syntax.match(input) }

      command_class = syntax_and_class.nil? ? UnknownCommand : syntax_and_class[1]
      syntax_match_data ||= {} # if no syntaxes matched

      [command_class, syntax_match_data.to_hash]
    end

    def register_command_class(klass)
      klass.syntaxes.each { |syntax| register_syntax(syntax, klass) }
    end

    def register_syntax(syntax, klass)
      @syntaxes[syntax] = klass
    end
  end
end
