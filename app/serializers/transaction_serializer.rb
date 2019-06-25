class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :invoice_id, :result, :credit_card_number
end
