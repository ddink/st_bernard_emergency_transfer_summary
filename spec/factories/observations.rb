FactoryBot.define do
  factory :observation do
    description { "It appears to be a fracture." }

    trait :with_admission do
      admission
    end
  end
end
