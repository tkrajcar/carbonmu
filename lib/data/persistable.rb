module CarbonMU
  module Persistable
    def _id
      @_id ||= SecureRandom.uuid
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def save
      DataManager.persist(self)
    end

    def as_hash
      additional_fields = {_id: _id, _class: self.class.name}
      Hash[fields.map {|k| [k.to_sym, self.send(k)] }].merge(additional_fields)
    end

    def fields
      self.class.fields
    end

    module ClassMethods
      def self.extended(base)
        base.instance_eval do
          class << self; attr_reader :fields; end
          @fields = []
        end
      end

      def field(name)
        attr_accessor name
        @fields << name
      end

      def read_only_field(name)
        attr_reader name
        @fields << name
      end
    end

  end
end
