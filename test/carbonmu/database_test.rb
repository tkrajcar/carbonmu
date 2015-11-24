require_relative "../test_helper.rb"

class DatabaseTest < Minitest::Test
  def setup
    DatabaseCleaner.clean
    @database = Database.new
    @database.ensure_starter_objects
  end

  # test specials
  [
    [Room, :starting_room, "Starting Room", "starting room for newly-created players"],
    [Room, :lostandfound_room, "Lost & Found Room", "thing that was holding them gets destroyed"],
    [Player, :superadmin_player, "Superadmin", "Obviously the most powerful of his race, it could kill us all."]
  ].each do |klass, special_name, name, description|
    define_method("test_creates_#{special_name}") do
      subject = klass.where(_special: special_name).first
      assert_equal klass, subject.class
      assert_equal name, subject.name
      assert_includes subject.description, description
    end
  end
end
