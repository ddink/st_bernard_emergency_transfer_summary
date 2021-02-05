FactoryBot.define do
  factory :medication_order do
    name { "Morphine" }
    dosage { "0.13" }
    necessity { "Fracture" }
    mass_unit { :mg }
    medication_route { :PO }

    trait :with_patient do
      patient_id { build_stubbed(:patient).id }
    end
  end
end
