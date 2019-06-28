require 'rails_helper'

RSpec.describe "InvoiceItem API" do
  it "delivers a list of all InvoiceItem" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(3)
  end

  it "delivers a single InvoiceItem by ID" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "delivers the Item for a single InvoiceItem" do
    item          = create(:item)
    invoice_item  = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    invoice_item_item = JSON.parse(response.body)["data"]

    expect(invoice_item_item["id"].to_i).to eq(item.id)
  end

  it "delivers the Invoice for a single InvoiceItem" do
    invoice       = create(:invoice)
    invoice_item  = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    invoice_item_invoice = JSON.parse(response.body)["data"]

    expect(invoice_item_invoice["id"].to_i).to eq(invoice.id)
  end
end
