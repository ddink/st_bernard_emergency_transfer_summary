FactoryBot.define do
  factory :symptom do
    description { "Shooting pain in the leg." }

    trait :with_admission do
      admission
    end
  end
end
