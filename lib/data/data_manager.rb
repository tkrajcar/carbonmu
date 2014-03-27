require 'celluloid'

module CarbonMU
  module DataManager
    @store = {}

    def self.persist(obj)
      data_engine.async.persist(obj.dup)
    end

    def self.[]=(key, value)
      @store[key] = value
    end

    def self.[](key)
      @store[key] || raise(ObjectNotFoundError, "Requested object '#{key}' not present in DataManager!")
    end

    def self.data_engine
      Celluloid::Actor[:data_engine]
    end
  end
end