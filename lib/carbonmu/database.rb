require "mongoid"

module CarbonMU
  class Database
    include Celluloid::Logger

    def initialize
      Mongoid.logger.level = ::Logger::DEBUG
      Mongoid.load!("config/database.yml", ENV["MONGOID_ENV"] || :production)
      begin
        ::Mongoid::Tasks::Database.create_indexes
      rescue Moped::Errors::ConnectionFailure => e
        error "Couldn't connect to MongoDB server! #{e.message}"
      end
    end

    def ensure_starter_objects
      ensure_special_exists(:starting_room, Room, {name: "Starting Room", description: "This is the starting room for newly-created players. Feel free to rename and re-describe it."})
      ensure_special_exists(:lostandfound_room, Room, {name: "Lost & Found Room", description: "This is the room where objects and players go if the thing that was holding them gets destroyed."})
      ensure_special_exists(:superadmin_player, Player, {name: "Superadmin", description: "Obviously the most powerful of his race, it could kill us all."})
    end

    def ensure_special_exists(special, klass, attributes)
      klass.create!(attributes.merge(_special: special)) if klass.where(_special: special).count == 0
    end
  end
end
