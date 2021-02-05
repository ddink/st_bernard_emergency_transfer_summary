FactoryBot.define do
  factory :allergy do
    description { "Flu Symptoms" }
    trait :with_patient do
      patient_id { build_stubbed(:patient).id }
    end
  end
end
