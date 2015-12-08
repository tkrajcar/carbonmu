module CarbonMU
  class InteractiveConnection
    attr_accessor :player, :locale
    attr_reader :id

    def initialize(arg = nil)
      @id = SecureRandom.uuid
      @locale = "en" #TODO set locale after authentication
      after_initialize(arg)
    end

    def after_initialize(arg)
      nil # to be implemented by subclasses, if desired
    end

    def run
      raise NotImplementedError
    end

    def write
      raise NotImplementedError
    end

    def write_translated(message, args = {})
      args.merge!(locale: @locale)
      write(Internationalization.t(message, args))
    end

    def server
      Celluloid::Actor[:server]
    end
  end
end

