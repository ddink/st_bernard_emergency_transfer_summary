FactoryBot.define do
  factory :diagnosis do
    coding_system { "COBOL" }
    code { "code" }
    description { "Broken Leg" }

    trait :with_patient do
      patient
    end

    trait :with_admission do
      admission
    end
  end
end
