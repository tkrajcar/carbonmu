module CarbonMU
  module Persistable
    attr_reader :_id

    def _id
      _id ||= SecureRandom.uuid
    end

    def self.included(base)
      base.extend(ClassMethods)
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
