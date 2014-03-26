require 'celluloid'

module CarbonMU
  class DataManager
    include Celluloid

    def self.persist(obj)
      Actor[:data_engine].persist(obj)
    end
  end
end