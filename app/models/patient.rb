class Patient < ApplicationRecord
  enum gender: [:male, :female, :other]

  has_one :admission
  has_many :allergies
  has_many :chronic_conditions, foreign_key: "patient_id", class_name: "Diagnosis"
  has_many :medications, foreign_key: "patient_id", class_name: "MedicationOrder"
  has_many :diagnostic_procedures
  has_many :diagnoses
  has_many :treatments

  validates_presence_of :first_name, :middle_name, :last_name, :medical_record, :gender
  validates :medical_record, numericality: { only_integer: true,
                                             greater_than_or_equal_to: 10000,
                                             less_than_or_equal_to: 99999 }
  validates :gender, inclusion: { in: ['male', 'female', 'other'] }
end
