module GameObjectDescendant
  def test_stored_in_game_objects_collection
    assert_equal "game_objects", @subject.collection.name
  end

  def test_has_required_fields
    assert_includes GameObject.fields, "name"
    assert_includes GameObject.fields, "description"
    assert_includes GameObject.fields, "_special"
  end
end
