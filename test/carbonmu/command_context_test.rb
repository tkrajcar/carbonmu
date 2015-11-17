require_relative "../test_helper.rb"

class CommandContextTest < Minitest::Test
  def test_stores_attributes
    player = mock("Player")
    connection = mock("Connection")
    connection.expects(:player).returns(player)
    command = "FOO"
    params = { boo: "bot" }

    cc = CommandContext.new(connection: connection, raw_command: command, params: params)

    assert_equal cc.connection, connection
    assert_equal cc.player, player
    assert_equal cc.raw_command, command
    assert_equal cc.params, params
    assert_equal cc.attributes, CommandContext.attributes
  end

  def test_has_correct_attributes
    expected_attributes = [:connection, :player, :raw_command, :params]
    assert_equal CommandContext.attributes, expected_attributes
  end
end
