FactoryBot.define do
  factory :treatment do
    description { "Wrap the leg in a cast." }
    necessity { "Leg length cast" }
    patient_id { create(:patient).id }
  end
end
