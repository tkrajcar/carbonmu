require_relative "../test_helper.rb"

class ConnectionTest < Minitest::Test
  include Helpers

  def setup
    @id = "foo"
    @connection = Connection.new(@id)
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

  def test_write_translated_passes_to_server
    server = stub_carbonmu_server
    server.expects(:write_to_connection).with(@id, @message, @translation_args)

    @connection.write_translated(@message, @translation_args)
  end

  def test_aliases_write_to_write_translated
    assert_equal Connection.instance_method(:write), Connection.instance_method(:write_translated)
  end

  def test_write_raw_passes_to_server
    server = stub_carbonmu_server
    server.expects(:write_to_connection_raw).with(@id, @message)

    @connection.write_raw(@message)
  end

  def test_player_is_nil_for_new_connections
    assert_nil @connection.player
  end
end
