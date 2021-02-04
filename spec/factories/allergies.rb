FactoryBot.define do
  factory :allergy do
    description { "Flu Symptoms" }
    patient_id { rand 100 }
  end
end
