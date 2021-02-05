class MedicationOrder < ApplicationRecord
  enum mass_unit: [:mg]
  enum medication_route: [:PO, :IM, :SC]

  has_one :frequency, foreign_key: 'medication_order_id', class_name: 'OrderFrequency'

  validates_presence_of :name, :mass_unit, :dosage, :frequency

  class << self
    def unit
      mass_units
    end

    def route
      medication_routes
    end
  end
end
