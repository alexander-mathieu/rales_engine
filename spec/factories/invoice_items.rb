FactoryBot.define do
  factory :invoice_item do
    association :item, factory: :item
    association :invoice, factory: :invoice
    
    sequence(:quantity) { |n| ("#{n}".to_i + 1) * 2 }
    sequence(:unit_price) { |n| ("#{n}".to_i + 1) * 1.5 }
  end
end
