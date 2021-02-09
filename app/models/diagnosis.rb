class Diagnosis < ApplicationRecord
  belongs_to :patient
  belongs_to :admission

  validates_presence_of :description

  scope :chronic_conditions, -> { where(chronic_condition: true) }
  scope :regular_diagnoses, -> { where(chronic_condition: [nil, false]) }
end
