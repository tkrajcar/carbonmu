module CarbonMU
  module Container
    extend ActiveSupport::Concern
    included do
      include Mongoid::Document

      has_many :contents, class_name: "CarbonMU::GameObject", foreign_key: :location
    end
  end
end
