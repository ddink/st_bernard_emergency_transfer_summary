FactoryBot.define do
  factory :diagnostic_procedure do
    description { "Put his leg in a splint." }

    trait :with_patient do
      patient_id { build_stubbed(:patient).id }
    end
  end
end
