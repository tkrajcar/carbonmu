module CarbonMU
  module Movable
    extend ActiveSupport::Concern
    included do
      include Mongoid::Document

      belongs_to :location, class_name: "CarbonMU::GameObject", inverse_of: :contents, index: true

      validates_presence_of :location
    end
  end
end
