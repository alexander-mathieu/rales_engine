FactoryBot.define do
  factory :transaction do
    association :invoice, factory: :invoice

    sequence :credit_card_number { |n| (("1111111111111111" + "#{n}").to_i) }
    result { "success" }
  end

  factory :failed_transaction, parent: :transaction do
    association :invoice, factory: :invoice
    
    result { "failure"}
  end
end
