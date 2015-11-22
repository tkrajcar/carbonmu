require_relative "../test_helper.rb"

class ParserTest < Minitest::Test
  class ParseTestCommand < Command
    syntax "testing_good_command"
  end

  class TestEmptyClass; end

  def setup
    @parser = Parser.new
  end

  def test_parse_executes_unknowncommand_with_a_bad_command
    @connection = mock("Connection", player: stub_everything("Player"))
    UnknownCommand.any_instance.expects(:execute)

    @parser.parse_and_execute(@connection, "DEFINITELY_NEVER_GOING_TO_BE_A_GOOD_COMMAND")
  end

  def test_parse_executes_a_good_command
    @connection = mock("Connection", player: stub_everything("Player"))
    ParseTestCommand.any_instance.expects(:execute)

    @parser.parse_and_execute(@connection, "testing_good_command")
  end

  def test_register_syntax_remembers_given_syntax_and_class
    @parser.register_syntax("foo", TestEmptyClass)

    assert_equal TestEmptyClass, @parser.syntaxes["foo"]
  end
end
