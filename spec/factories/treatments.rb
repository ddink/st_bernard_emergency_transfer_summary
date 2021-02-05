FactoryBot.define do
  factory :treatment do
    description { "Wrap the leg in a cast." }
    necessity { "Leg length cast" }

    trait :with_patient do
      patient_id { build_stubbed(:patient).id }
    end
  end
end
