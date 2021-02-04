FactoryBot.define do
  factory :patient do
    first_name { "John" }
    middle_name { "Quincy" }
    last_name { "Doe" }
    medical_record { rand 10000..99999 }
    dob { "2021-02-04 08:52:02" }
    gender { 'male' }
  end
end
