require 'multi_json'
require 'celluloid'

module CarbonMU
  class EmbeddedDataEngine
    include Celluloid

    def persist(obj)
      raise ArgumentError, "attempted to persist object without _id" unless obj.respond_to? :_id
      #raise ArgumentError, "attempted to persist object without fields" unless obj.respond_to? :fields
      File.open("db/#{obj._id}.json", 'w') do |f|
        f.write(MultiJson.dump(obj.as_hash))
      end
    end
  end
end