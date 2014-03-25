require 'active_support'

module CarbonMU
  class PersistedObject
    @@fields = []

    cattr_reader :fields

    def self.field(name)
      cattr_accessor name
      add_to_field_list(name)
    end

    def self.read_only_field(name)
      cattr_reader name
      add_to_field_list(name)
    end

    def self.add_to_field_list(name)
      @@fields << name
    end

    read_only_field :_id

    def _id
      _id ||= SecureRandom.uuid
    end
  end
end