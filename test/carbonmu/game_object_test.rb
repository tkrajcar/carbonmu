require_relative "../test_helper.rb"

class GameObjectTest < Minitest::Test
  include GameObjectDescendant

  def setup
    @subject = GameObject
    @g = GameObject.new
  end

  def test_it_has_a_default_description
    assert_equal @g.description, "You see nothing special."
  end
end
