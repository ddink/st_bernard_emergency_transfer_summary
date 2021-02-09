require 'description_format'

class Patient < ApplicationRecord
  include DescriptionFormat

  enum gender: [:male, :female, :other]

  has_one :admission
  has_one :facility, through: :admission

  has_many :allergies
  has_many :medications, foreign_key: "patient_id", class_name: "MedicationOrder"
  has_many :diagnostic_procedures
  has_many :diagnoses
  has_many :treatments

  validates_presence_of :first_name, :middle_name, :last_name, :medical_record, :gender
  validates :medical_record, numericality: { only_integer: true,
                                             greater_than_or_equal_to: 10000,
                                             less_than_or_equal_to: 99999 }
  validates :gender, inclusion: { in: ['male', 'female', 'other'] }

  def emergency_transfer_summary
    [
        "This #{age} years old #{gender} was admitted to #{facility.name} emergency facility "\
        "on #{admission.formatted_date} at #{admission.formatted_time} due to #{admission.diagnoses_description}. "\
        "The observed symptoms on admission were #{admission.symptoms_description}. "\
        "#{admission.observations_description}.",

        "Upon asking about known allergies, the patient disclosed #{allergies_description}. "\
        "Upon asking about chronic conditions, the patient disclosed #{chronic_conditions_description}. "\
        "The patient was administered with #{medication_administered}.",

        "The staff performed #{procedures_description}, revealing #{diagnoses_description}. Our team proceeded "\
        "#{treatments_description}."
    ].join("\n\n<br><br>")
  end

  def age
    ((Time.zone.now - dob.to_time) / 1.year.seconds).floor.to_s
  end

  def allergies_description
    formatted_description_for allergies
  end

  def chronic_conditions_description
    formatted_description_for chronic_conditions
  end

  def diagnoses_description
    formatted_description_for regular_diagnoses
  end

  def medication_administered
    description = []
    medications.each do |m|
      description << "#{m.name} #{m.dosage_decimal}#{m.unit} #{m.route}"\
                     " #{m.frequency_value}#{m.frequency.unit} to #{m.necessity}"
    end
    description.join(", and ")
  end

  def procedures_description
    description = []
    diagnostic_procedures.each do |p|
      description << "#{p.description} on #{p.formatted_date} at #{p.formatted_time}"
    end
    description.join(", and ")
  end

  def treatments_description
    description = []
    treatments.each { |t| description << "to #{t.description} to #{t.necessity}" }
    description.join(" and ")
  end

  def chronic_conditions
    diagnoses.chronic_conditions
  end

  def regular_diagnoses
    diagnoses.regular_diagnoses
  end
end