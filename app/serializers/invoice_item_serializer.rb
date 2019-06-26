class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  attributes :item_id,
             :quantity,
             :unit_price,
             :invoice_id
end
