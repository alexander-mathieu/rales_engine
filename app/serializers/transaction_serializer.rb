class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :result,
             :invoice_id,
             :credit_card_number
end
