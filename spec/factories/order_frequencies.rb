FactoryBot.define do
  factory :order_frequency do
    value { "Every other" }
    unit { :hour }

    trait :with_medication_order do
      medication_order_id { build_stubbed(:medication_order).id }
    end
  end
end
