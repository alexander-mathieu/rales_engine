class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :merchant

  has_many :items

  attributes :id,
             :status,
             :customer_id,
             :merchant_id
end
