class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  attributes :status,
             :customer_id,
             :merchant_id
end
