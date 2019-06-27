class MerchantSerializer
  include FastJsonapi::ObjectSerializer

  has_many :items
  has_many :invoices

  attributes :id,
             :name
end
