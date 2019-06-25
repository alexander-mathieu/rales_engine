class ItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
             :unit_price,
             :description,
             :merchant_id
end
