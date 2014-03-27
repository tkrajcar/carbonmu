require 'celluloid'

module CarbonMU
  module DataManager

    def self.persist(obj)
      data_engine.async.persist(obj.dup)
    end

    def self.data_engine
      Celluloid::Actor[:data_engine]
    end
  end
end