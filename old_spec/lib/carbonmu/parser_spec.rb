require 'spec_helper'

describe Parser do
  class ParseTestCommand < Command
    syntax "testing_good_command"
  end

  let (:parser) { Parser.new }
  let (:connection) { double(Connection).as_null_object }

  context '.parse_and_execute' do
    it "handles a bad command" do
      expect_any_instance_of(UnknownCommand).to receive(:execute)

      parser.parse_and_execute(connection, "DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND")
    end

    it "calls .execute on a good command" do
      expect_any_instance_of(ParseTestCommand).to receive(:execute)
      parser.parse_and_execute(connection, "testing_good_command")
    end
  end

  context '.register_syntax' do
    it "remembers a given syntax and class" do
      class TestEmptyClass; end
      parser.register_syntax("foo", TestEmptyClass)
      expect(parser.syntaxes["foo"]).to eq(TestEmptyClass)
    end
  end
end
