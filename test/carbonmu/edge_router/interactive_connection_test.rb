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

  def test_doesnt_write
    assert_raises(NotImplementedError) { @connection.write }
  end

  def test_write_translated_merges_with_locale
    @connection.locale = "Aurebesh"
    message = "Oh hello."
    translated_message = "Beep boop bop"
    translation_args = { foo: "bar" }
    expected_translation_args = { foo: "bar", locale: "Aurebesh" }

    Internationalization.expects(:t).with(message, expected_translation_args).returns(translated_message)
    @connection.expects(:write).with(translated_message)

    @connection.write_translated(message, translation_args)
  end
end
