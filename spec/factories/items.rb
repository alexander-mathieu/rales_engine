FactoryBot.define do
  factory :item do
    association :merchant, factory: :merchant
    sequence :name { |n| "Item #{n}" }
    sequence :unit_price { |n| ("#{n}".to_i + 1) * 1.5 }
    sequence :description { |n| "Description #{n}" }
  end
end
