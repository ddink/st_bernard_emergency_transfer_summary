class MedicationOrder < ApplicationRecord
  enum mass_unit: [:mg]
  enum medication_route: [:PO, :IM, :SC]

  has_one :frequency, foreign_key: 'medication_order_id', class_name: 'OrderFrequency'

  validates_presence_of :name, :mass_unit, :dosage, :frequency

  def unit
    mass_unit
  end

  def route
    medication_route
  end

  def dosage_decimal
    dosage.to_s.sub(/\.?0+$/, '')
  end

  def frequency_value
    frequency.value
  end

  private

  class << self
    def unit
      mass_units
    end

    def route
      medication_routes
    end
  end
end
