class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :result,
             :invoice_id,
             :credit_card_number
end
