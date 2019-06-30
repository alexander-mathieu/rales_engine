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

  describe "business intelligence endpoints" do
    before :each do
      @item_1  = create(:item, unit_price: 1000)
      @item_2  = create(:item, unit_price: 2000)
      @item_3  = create(:item, unit_price: 3000)
      @item_4  = create(:item, unit_price: 4000)
      @item_5  = create(:item, unit_price: 5000)
      @item_6  = create(:item, unit_price: 6000)
      @item_7  = create(:item, unit_price: 7000)
      @item_8  = create(:item, unit_price: 8000)
      @item_9  = create(:item, unit_price: 9000)
      @item_10 = create(:item, unit_price: 1000)
      @item_11 = create(:item, unit_price: 2000)
      @item_12 = create(:item, unit_price: 3000)
      @item_13 = create(:item, unit_price: 4000)
      @item_14 = create(:item, unit_price: 5000)
      @item_15 = create(:item, unit_price: 6000)
      @item_16 = create(:item, unit_price: 7000)

      @invoice_1  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_4  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_5  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_7  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_8  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_9  = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_10 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_11 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_12 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_13 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_14 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_15 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_16 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_8, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_9, item: @item_9, quantity: 9, unit_price: 9000)
      create(:invoice_item, invoice: @invoice_9, item: @item_10, quantity: 10, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_10, item: @item_9, quantity: 9, unit_price: 9000)
      create(:invoice_item, invoice: @invoice_10, item: @item_10, quantity: 10, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_11, item: @item_11, quantity: 11, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_11, item: @item_12, quantity: 12, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_12, item: @item_11, quantity: 11, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_12, item: @item_12, quantity: 12, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_13, item: @item_13, quantity: 13, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_13, item: @item_14, quantity: 14, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_14, item: @item_13, quantity: 13, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_14, item: @item_14, quantity: 14, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_15, item: @item_15, quantity: 15, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_15, item: @item_16, quantity: 16, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_16, item: @item_15, quantity: 15, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_16, item: @item_16, quantity: 16, unit_price: 7000)

      create(:transaction, invoice: @invoice_1)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create(:transaction, invoice: @invoice_5)
      create(:transaction, invoice: @invoice_6)
      create(:transaction, invoice: @invoice_7)
      create(:transaction, invoice: @invoice_8)
      create(:transaction, invoice: @invoice_9)
      create(:transaction, invoice: @invoice_10)
      create(:transaction, invoice: @invoice_11)
      create(:transaction, invoice: @invoice_12)

      create(:failed_transaction, invoice: @invoice_13)
      create(:failed_transaction, invoice: @invoice_14)
      create(:failed_transaction, invoice: @invoice_15)
      create(:failed_transaction, invoice: @invoice_16)
    end

    it "delivers the best day for an Item by told sales" do
      get "/api/v1/items/#{@item_1.id}/best_day"

      expect(response).to be_successful

      item  = JSON.parse(response.body)["data"]["attributes"]

      expect(item["best_day"]).to eq("2012-03-20")

      get "/api/v1/items/#{@item_6.id}/best_day"

      item  = JSON.parse(response.body)["data"]["attributes"]

      expect(item["best_day"]).to eq("2012-03-22")
    end

    it "delivers a variable length list of Items by total sales" do
      get "/api/v1/items/most_items?quantity=2"

      expect(response).to be_successful

      items  = JSON.parse(response.body)["data"]

      expect(items[0]["id"].to_i).to eq(@item_12.id)
      expect(items[1]["id"].to_i).to eq(@item_11.id)

      get "/api/v1/items/most_items?quantity=4"

      expect(response).to be_successful

      items  = JSON.parse(response.body)["data"]

      expect(items[0]["id"].to_i).to eq(@item_12.id)
      expect(items[1]["id"].to_i).to eq(@item_11.id)
      expect(items[2]["id"].to_i).to eq(@item_10.id)
      expect(items[3]["id"].to_i).to eq(@item_9.id)
    end

    it "delivers a variable length list of Items by most revenue" do
      get "/api/v1/items/most_revenue?quantity=2"

      expect(response).to be_successful

      items  = JSON.parse(response.body)["data"]

      expect(items[0]["id"].to_i).to eq(@item_9.id)
      expect(items[1]["id"].to_i).to eq(@item_8.id)

      get "/api/v1/items/most_revenue?quantity=4"

      expect(response).to be_successful

      items  = JSON.parse(response.body)["data"]

      expect(items[0]["id"].to_i).to eq(@item_9.id)
      expect(items[1]["id"].to_i).to eq(@item_8.id)
      expect(items[2]["id"].to_i).to eq(@item_7.id)
      expect(items[3]["id"].to_i).to eq(@item_6.id)
    end
  end
end
