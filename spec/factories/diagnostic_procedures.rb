FactoryBot.define do
  factory :diagnostic_procedure do
    description { "Put his leg in a splint." }
    patient_id { create(:patient).id }
  end
end
