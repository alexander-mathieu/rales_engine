class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :merchant

  attributes :id,
             :status,
             :customer_id,
             :merchant_id
end
