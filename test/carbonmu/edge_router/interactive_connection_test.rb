require_relative "../test_helper.rb"

class InteractiveConnectionTest < Minitest::Test
  include Helpers

  def setup
    Celluloid.boot
    @id = "foo"
    @connection = InteractiveConnection.new(@id)
    @message = "Watson, come here"
    @translation_args = { foo: "bar" }
    @player = mock("Player")
  end

  def test_has_id
    assert_equal @connection.id, @id
  end

  def test_id_cant_be_modified
    assert_raises(NameError) { connection.id = @id }
  end

  def test_player_is_nil_for_new_connections
    assert_nil @connection.player
  end
end
