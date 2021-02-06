FactoryBot.define do
  factory :order_frequency do
    value { "q6" }
    unit { :hr }

    trait :with_medication_order do
      medication_order_id { build_stubbed(:medication_order).id }
    end
  end
end
