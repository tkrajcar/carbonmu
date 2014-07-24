module CarbonMU
  module Persistable
    attr_reader :_created, :_id

    def self.universal_fields
      ["_id", "_class", "_created"]
    end

    def initialize(params = Hash.new)
      @_id = params["_id"] || SecureRandom.uuid
      @_created = params["_created"] || DateTime.now
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
        obj = klass.new(hash.select {|k,v| Persistable.universal_fields.include? k}) # Pass all universal fields into constructor.
        hash.each do |k, v|
          next if Persistable.universal_fields.include?(k)
          obj.send("#{k}=", "#{v}")
        end
        obj
      end
    end

  end
end
