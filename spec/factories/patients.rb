FactoryBot.define do
  factory :patient do
    first_name { "John" }
    middle_name { "Quincy" }
    last_name { "Doe" }
    medical_record { rand 10000..99999 }
    dob { 21.years.ago }
    gender { 'male' }
  end
end
