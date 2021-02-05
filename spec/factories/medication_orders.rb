FactoryBot.define do
  factory :medication_order do
    name { "MyString" }
    dosage { "9.99" }
    necessity { "MyText" }
    mass_unit { 1 }
    medication_route { 1 }
    patient_id { 1 }
  end
end
