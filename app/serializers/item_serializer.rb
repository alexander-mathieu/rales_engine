class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
             :unit_price,
             :description,
             :merchant_id

  attribute :unit_price do |item|
   item.unit_price = (item.unit_price.to_f/100).to_s
  end
end
