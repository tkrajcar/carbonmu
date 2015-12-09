require "bcrypt"

require "carbonmu/game_objects/movable"
require "carbonmu/game_objects/container"
require "carbonmu/internationalization"

module CarbonMU
  class Player < GameObject
    include Movable
    include Container
    include BCrypt
    include Mongoid::Document
    include Mongoid::Timestamps

    attr_accessor :password

    field :email,         :type => String
    field :password_hash, :type => String
    field :locale, type: :string, default: "en" # TODO configurable game-wide default locale

    validates_uniqueness_of :email, :message => "There is already a player with that email address.", :allow_nil => true

    before_validation :encrypt_password
    before_validation :default_location

    def default_location
      self.location ||= Room.starting
    end

    def notify(message, args = {})
      message_translated = Internationalization.t(message, args.merge(locale: locale))
      notify_raw(message_translated)
    end

    def notify_raw(message)
      connections.each { |connection| connection.write(message) }
    end

    def connections
      CarbonMU.edge_router.connections_for_player(_id)
    end

    def self.superadmin
      find_by(_special: :superadmin_player)
    end

    def authenticate(user_pass)
      Password.new(self.password_hash) == user_pass
    end

    protected

    def encrypt_password
      self.password_hash = Password.create(self.password)
    end
  end
end
