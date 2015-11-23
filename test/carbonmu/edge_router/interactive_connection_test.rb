require_relative "../../test_helper.rb"

class InteractiveConnectionTest < Minitest::Test
  include Helpers

  def setup
    @connection = InteractiveConnection.new
  end

  def test_has_id
    refute_nil @connection.id
  end

  def test_id_cant_be_modified
    assert_raises(NameError) { @connection.id = @id }
  end

  def test_doesnt_run
    assert_raises(NotImplementedError) { @connection.run }
  end
end
