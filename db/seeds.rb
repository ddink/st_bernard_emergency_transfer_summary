# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@moment_of_admission = DateTime.new(2021, 2, 8, 11)

def create_allergy(a=1)
  if a == 1
    Allergy.create!(description: "hypersensitivity to aspirin or NSAIDS")
  else
    Allergy.create!(description: "gluten intolerance")
  end
end

def create_chronic_condition(a=1)
  if a == 1
    Diagnosis.create!(description: "Asthma (J45)", chronic_condition: true)
  else
    Diagnosis.create!(description: "Pulmonary Disease (CPOD)", chronic_condition: true)
  end
end

def create_order_frequency(a=1)
  if a == 1
    OrderFrequency.create!(value: 'q4', unit: :hr)
  else
    OrderFrequency.create!(value: 'q6', unit: :hr)
  end
end

def create_medication(a=1, frequency)
  if a == 1
    MedicationOrder.create!(name: 'Acetaminophen') do |m|
      m.dosage = '500'
      m.necessity = 'relieve pain'
      m.frequency = frequency
    end
  else
    MedicationOrder.create!(name: 'Naproxen') do |m|
      m.dosage = '500'
      m.medication_route = :IM
      m.necessity = 'relieve swelling'
      m.frequency = frequency
    end
  end
end

def create_diagnostic_procedure(a=1)
  if a == 1
    DiagnosticProcedure.create!(description: 'an exploratory radiography',
                                created_at: @moment_of_admission)
  else
    DiagnosticProcedure.create!(description: 'an ultrasound',
                                created_at: @moment_of_admission + 90.minutes)
  end
end

def create_diagnosis(a=1)
  if a == 1
    Diagnosis.create!(description: 'right tibia (S82.101A)')
  else
    Diagnosis.create!(description: 'fibula (S82.102B)')
  end
end

def create_treatment(a=1)
  if a == 1
    Treatment.create!(description: 'temporary bracing', necessity: 'restrict the motion')
  else
    Treatment.create!(description: 'triage for transport to hospital',
                      necessity: 'receive urgent care')
  end
end

def create_observation(a=1)
  if a == 1
    Observation.create!(description: 'no soft tissues were damaged')
  else
    Observation.create!(description: 'appears to be a fracture')
  end
end

def create_symptom(a=1)
  if a == 1
    Symptom.create!(description: "Shooting pain in the leg")
  else
    Symptom.create!(description: "the leg is bleeding")
  end
end

unless Rails.env.production?
  User.find_or_create_by!(emergency_staff: true)
  User.find_or_create_by!(emergency_staff: false)

  facility = Facility.find_or_create_by!(name: 'Blue Alps Ski Camp')

  allergy1 = create_allergy
  allergy2 = create_allergy 2
  allergy3 = create_allergy
  allergy4 = create_allergy 2
  allergy5 = create_allergy
  allergy6 = create_allergy 2

  chronic_condition1 = create_chronic_condition
  chronic_condition2 = create_chronic_condition 2
  chronic_condition3 = create_chronic_condition
  chronic_condition4 = create_chronic_condition 2
  chronic_condition5 = create_chronic_condition
  chronic_condition6 = create_chronic_condition 2

  frequency1 = create_order_frequency
  frequency2 = create_order_frequency 2
  frequency3 = create_order_frequency
  frequency4 = create_order_frequency 2
  frequency5 = create_order_frequency
  frequency6 = create_order_frequency 2

  medication1 = create_medication 1, frequency1
  medication2 = create_medication 2, frequency2

  medication3 = create_medication 1, frequency3
  medication4 = create_medication 2, frequency4

  medication5 = create_medication 1, frequency5
  medication6 = create_medication 2, frequency6

  diagnostic_procedure1 = create_diagnostic_procedure
  diagnostic_procedure2 = create_diagnostic_procedure 2
  diagnostic_procedure3 = create_diagnostic_procedure
  diagnostic_procedure4 = create_diagnostic_procedure 2
  diagnostic_procedure5 = create_diagnostic_procedure
  diagnostic_procedure6 = create_diagnostic_procedure 2

  diagnosis1 = create_diagnosis
  diagnosis2 = create_diagnosis 2
  diagnosis3 = create_diagnosis
  diagnosis4 = create_diagnosis 2
  diagnosis5 = create_diagnosis
  diagnosis6 = create_diagnosis 2
  diagnosis7 = create_diagnosis
  diagnosis8 = create_diagnosis 2
  diagnosis9 = create_diagnosis
  diagnosis10 = create_diagnosis 2
  diagnosis11 = create_diagnosis
  diagnosis12 = create_diagnosis 2

  treatment1 = create_treatment
  treatment2 = create_treatment 2
  treatment3 = create_treatment
  treatment4 = create_treatment 2
  treatment5 = create_treatment
  treatment6 = create_treatment 2

  patient1 = Patient.find_or_create_by!(medical_record: Faker::Number.between(from: 10000, to: 99999)) do |p|
    p.first_name = Faker::Name.first_name
    p.middle_name = Faker::Name.middle_name
    p.last_name = Faker::Name.last_name
    p.dob = Faker::Date.birthday(min_age: 18, max_age: 65)
    p.gender = Faker::Gender.binary_type.downcase
    p.allergies = [allergy1, allergy2]
    p.medications = [medication1, medication2]
    p.diagnostic_procedures = [diagnostic_procedure1, diagnostic_procedure2]
    p.diagnoses = [diagnosis1, diagnosis2, chronic_condition1, chronic_condition2]
    p.treatments = [treatment1, treatment2]
  end

  patient2 = Patient.find_or_create_by!(medical_record: Faker::Number.between(from: 10000, to: 99999)) do |p|
    p.first_name = Faker::Name.first_name
    p.middle_name = Faker::Name.middle_name
    p.last_name = Faker::Name.last_name
    p.dob = Faker::Date.birthday(min_age: 18, max_age: 65)
    p.gender = Faker::Gender.binary_type.downcase
    p.allergies = [allergy3, allergy4]
    p.medications = [medication3, medication4]
    p.diagnostic_procedures = [diagnostic_procedure3, diagnostic_procedure4]
    p.diagnoses = [diagnosis3, diagnosis4, chronic_condition3, chronic_condition4]
    p.treatments = [treatment3, treatment4]
  end

  patient3 = Patient.find_or_create_by!(medical_record: Faker::Number.between(from: 10000, to: 99999)) do |p|
    p.first_name = Faker::Name.first_name
    p.middle_name = Faker::Name.middle_name
    p.last_name = Faker::Name.last_name
    p.dob = Faker::Date.birthday(min_age: 18, max_age: 65)
    p.gender = Faker::Gender.binary_type.downcase
    p.allergies = [allergy5, allergy6]
    p.medications = [medication5, medication6]
    p.diagnostic_procedures = [diagnostic_procedure5, diagnostic_procedure6]
    p.diagnoses = [diagnosis5, diagnosis6, chronic_condition5, chronic_condition6]
    p.treatments = [treatment5, treatment6]
  end

  observation1 = create_observation
  observation2 = create_observation 2
  observation3 = create_observation
  observation4 = create_observation 2
  observation5 = create_observation
  observation6 = create_observation 2

  symptom1 = create_symptom
  symptom2 = create_symptom 2
  symptom3 = create_symptom
  symptom4 = create_symptom 2
  symptom5 = create_symptom
  symptom6 = create_symptom 2

  Admission.find_or_create_by!(patient: patient1) do |admission|
    admission.facility = facility
    admission.observations = [observation1, observation2]
    admission.diagnoses = [diagnosis7, diagnosis8]
    admission.symptoms = [symptom1, symptom2]
    admission.created_at = @moment_of_admission
  end

  Admission.find_or_create_by!(patient: patient2) do |admission|
    admission.facility = facility
    admission.observations = [observation3, observation4]
    admission.diagnoses = [diagnosis9, diagnosis10]
    admission.symptoms = [symptom3, symptom4]
    admission.created_at = @moment_of_admission
  end

  Admission.find_or_create_by!(patient: patient3) do |admission|
    admission.facility = facility
    admission.observations = [observation5, observation6]
    admission.diagnoses = [diagnosis11, diagnosis12]
    admission.symptoms = [symptom5, symptom6]
    admission.created_at = @moment_of_admission
  end
end