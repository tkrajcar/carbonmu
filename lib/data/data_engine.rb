module CarbonMU
  class DataEngine
    def load(id)
      raise NotImplementedError
    end

    def persist(obj)
      raise NotImplementedError
    end
  end
end
