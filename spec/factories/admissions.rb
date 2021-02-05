FactoryBot.define do
  factory :admission do
    facility_id { build_stubbed(:facility).id }
    trait :with_patient do
      patient
    end
  end
end
