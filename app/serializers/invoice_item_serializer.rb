class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :item_id,
             :quantity,
             :unit_price,
             :invoice_id
end
