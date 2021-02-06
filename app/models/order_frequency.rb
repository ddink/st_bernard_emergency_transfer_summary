class OrderFrequency < ApplicationRecord
  enum unit: [:hr]
  validates_presence_of :value, :unit
end
