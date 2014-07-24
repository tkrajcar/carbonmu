module CarbonMU
  module Persistable
    attr_reader :_created

    def self.universal_fields
      [:_id, :_class, :_created]
    end

    def initialize
      @_created = DateTime.now
    end

    def _id=(value)
      raise RuntimeError, "Can't assign a _id to an object that already has one" unless @_id.nil?
      @_id = value
    end

    def _id
      @_id ||= SecureRandom.uuid
    end

    def _class
      self.class.name
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    def save
      DataManager.persist(self)
    end

    def as_hash
      Hash[fields.map {|k| [k.to_sym, self.send(k)] }]
    end

    def fields
      self.class.fields
    end

    module ClassMethods
      def self.extended(base)
        base.instance_eval do
          class << self; attr_reader :fields; end
          @fields = Persistable.universal_fields
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

      def from_hash(hash)
        raise ArgumentError, "called from_hash with a hash that does not contain _class" unless hash.has_key?("_class")
        klass = Object.const_get(hash["_class"])
        obj = klass.new
        hash.each do |k, v|
          next if k == "_class"
          obj.send("#{k}=", "#{v}")
        end
        obj
      end
    end

  end
end
