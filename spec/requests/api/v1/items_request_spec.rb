require 'rails_helper'

RSpec.describe "Items API" do
  it "delivers a list of all Items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(3)
  end

  it "delivers a single Item by ID" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(id)
  end

  it "delivers the InvoiceItems for a single Item" do
    item            = create(:item)

    invoice_item_1  = create(:invoice_item, item: item)
    invoice_item_2  = create(:invoice_item, item: item)
    invoice_item_3  = create(:invoice_item, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"

    expect(response).to be_successful

    item_invoice_items = JSON.parse(response.body)["data"]

    expect(item_invoice_items[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(item_invoice_items[1]["id"].to_i).to eq(invoice_item_2.id)
    expect(item_invoice_items[2]["id"].to_i).to eq(invoice_item_3.id)
  end

  it "delivers the Merchant for a single Item" do
    merchant = create(:merchant)
    item     = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body)["data"]

    expect(item_merchant["id"].to_i).to eq(merchant.id)
  end
end
