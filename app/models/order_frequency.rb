class OrderFrequency < ApplicationRecord
  enum unit: [:hour]

  validates_presence_of :value, :unit
end
