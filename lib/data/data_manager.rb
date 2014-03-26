require 'celluloid'

module CarbonMU
  class DataManager
    include Celluloid

    def self.persist(obj)
      Actor[:data_engine].async.persist(obj.dup)
    end
  end
end