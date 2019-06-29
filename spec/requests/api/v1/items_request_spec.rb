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

  it "finds a random Item" do
    create_list(:item, 4)

    ids = Item.pluck(:id)

    get "/api/v1/items/random"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(ids).to include(item[0]["id"].to_i)
  end

  it "finds a single Item by ID" do
    item_1 = create(:item)
    item_2 = create(:item)

    get "/api/v1/items/find?id=#{item_1.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?id=#{item_2.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds a single Item by merchant_id" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)

    get "/api/v1/items/find?merchant_id=#{item_1.merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?merchant_id=#{item_2.merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds a single Item by name" do
    item_1 = create(:item, name: "Item Name 1")
    item_2 = create(:item, name: "Item Name 2")

    get "/api/v1/items/find?name=#{item_1.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?name=#{item_2.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds a single Item by unit_price" do
    item_1 = create(:item, unit_price: 1234)
    item_2 = create(:item, unit_price: 5678)

    get "/api/v1/items/find?unit_price=#{item_1.unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?unit_price=#{item_2.unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds a single Item by description" do
    item_1 = create(:item, description: "Item Description 1")
    item_2 = create(:item, description: "Item Description 2")

    get "/api/v1/items/find?description=#{item_1.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?description=#{item_2.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds a single Item by created_at" do
    item_1 = create(:item, created_at: "2012-03-20T14:54:05.000Z")
    item_2 = create(:item, created_at: "2012-03-22T14:54:05.000Z")

    get "/api/v1/items/find?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]["attributes"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?created_at=#{item_2.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds a single Item by updated_at" do
    item_1 = create(:item, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    item_2 = create(:item, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

    get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find?updated_at=#{item_2.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by ID" do
    item_1 = create(:item)
    item_2 = create(:item)

    get "/api/v1/items/find_all?id=#{item_1.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)

    get "/api/v1/items/find_all?id=#{item_2.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by merchant_id" do
    merchant = create(:merchant)

    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)
    expect(item[1]["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by name" do
    item_1 = create(:item, name: "Item Name 1")
    item_2 = create(:item, name: "Item Name 1")

    get "/api/v1/items/find_all?name=#{item_1.name}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)
    expect(item[1]["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by unit_price" do
    item_1 = create(:item, unit_price: 1234)
    item_2 = create(:item, unit_price: 1234)

    get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)
    expect(item[1]["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by description" do
    item_1 = create(:item, description: "Item Description 1")
    item_2 = create(:item, description: "Item Description 1")

    get "/api/v1/items/find_all?description=#{item_1.description}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)
    expect(item[1]["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by created_at" do
    item_1 = create(:item, created_at: "2012-03-20T14:54:05.000Z")
    item_2 = create(:item, created_at: "2012-03-20T14:54:05.000Z")

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)
    expect(item[1]["id"].to_i).to eq(item_2.id)
  end

  it "finds all Items by updated_at" do
    item_1 = create(:item, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    item_2 = create(:item, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item[0]["id"].to_i).to eq(item_1.id)
    expect(item[1]["id"].to_i).to eq(item_2.id)
  end
end
