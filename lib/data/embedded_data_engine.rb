require 'multi_json'
require 'celluloid'

module CarbonMU
  class EmbeddedDataEngine < DataEngine
    include Celluloid

    def initialize(directory_name = 'db')
      @directory_name = directory_name
      Dir.mkdir(directory_name) unless Dir.exist?(directory_name)
    end

    def load(id)
      file_name = "#{@directory_name}/#{id}.json"
      raise ObjectNotFoundError, "can't find object with #{id}" unless File.exist?(file_name)
      file_raw = File.read(file_name)
      hash = MultiJson.load(file_raw)
      obj = Object.const_get(hash["_class"]).from_hash(hash)
      raise InvalidObjectError, "object in file has mismatched id!" unless obj._id == id
      obj
    end

    def persist(obj)
      raise ArgumentError, "attempted to persist object without _id" unless obj.respond_to? :_id
      raise ArgumentError, "attempted to persist object without fields" unless obj.respond_to? :fields
      File.open("#{@directory_name}/#{obj._id}.json", 'w') do |f|
        f.write(MultiJson.dump(obj.as_hash))
      end
    end
  end
end