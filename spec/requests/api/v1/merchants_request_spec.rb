require 'rails_helper'

RSpec.describe "Merchants API" do
  it "delivers a list of all Merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]

    expect(merchants.count).to eq(3)
  end

  it "delivers a single Merchant by ID" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(id)
  end

  it "delivers all Items for a single Merchant" do
    merchant = create(:merchant)

    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body)["data"]

    expect(merchant_items[0]["id"].to_i).to eq(item_1.id)
    expect(merchant_items[1]["id"].to_i).to eq(item_2.id)
    expect(merchant_items[2]["id"].to_i).to eq(item_3.id)
  end

  it "delivers all Invoices for a single Merchant" do
    merchant = create(:merchant)

    invoice_1 = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)
    invoice_3 = create(:invoice, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    merchant_invoices = JSON.parse(response.body)["data"]

    expect(merchant_invoices[0]["id"].to_i).to eq(invoice_1.id)
    expect(merchant_invoices[1]["id"].to_i).to eq(invoice_2.id)
    expect(merchant_invoices[2]["id"].to_i).to eq(invoice_3.id)
  end

  it "finds a random Merchant" do
    create_list(:merchant, 4)

    ids = Merchant.pluck(:id)

    get "/api/v1/merchants/random"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(ids).to include(merchant[0]["id"].to_i)
  end

  it "finds a single Merchant by ID" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_1.id)

    get "/api/v1/merchants/find?id=#{merchant_2.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_2.id)
  end

  it "finds a single Merchant by name" do
    merchant_1 = create(:merchant, name: "Merchant Name 1")
    merchant_2 = create(:merchant, name: "Merchant Name 2")

    get "/api/v1/merchants/find?name=#{merchant_1.name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_1.id)

    get "/api/v1/merchants/find?name=#{merchant_2.name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_2.id)
  end

  it "finds a single Merchant by created_at" do
    merchant_1 = create(:merchant, created_at: "2012-03-20T14:54:05.000Z")
    merchant_2 = create(:merchant, created_at: "2012-03-22T14:54:05.000Z")

    get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]["attributes"]

    expect(merchant["id"].to_i).to eq(merchant_1.id)

    get "/api/v1/merchants/find?created_at=#{merchant_2.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_2.id)
  end

  it "finds a single Merchant by updated_at" do
    merchant_1 = create(:merchant, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    merchant_2 = create(:merchant, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

    get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_1.id)

    get "/api/v1/merchants/find?updated_at=#{merchant_2.updated_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(merchant_2.id)
  end

  it "finds all Merchants by ID" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant[0]["id"].to_i).to eq(merchant_1.id)

    get "/api/v1/merchants/find_all?id=#{merchant_2.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant[0]["id"].to_i).to eq(merchant_2.id)
  end

  it "finds all Merchants by name" do
    merchant_1 = create(:merchant, name: "Merchant Name 1")
    merchant_2 = create(:merchant, name: "Merchant Name 1")

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant[0]["id"].to_i).to eq(merchant_1.id)
    expect(merchant[1]["id"].to_i).to eq(merchant_2.id)
  end

  it "finds all Merchants by created_at" do
    merchant_1 = create(:merchant, created_at: "2012-03-20T14:54:05.000Z")
    merchant_2 = create(:merchant, created_at: "2012-03-20T14:54:05.000Z")

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant[0]["id"].to_i).to eq(merchant_1.id)
    expect(merchant[1]["id"].to_i).to eq(merchant_2.id)
  end

  it "finds all Merchants by updated_at" do
    merchant_1 = create(:merchant, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    merchant_2 = create(:merchant, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant[0]["id"].to_i).to eq(merchant_1.id)
    expect(merchant[1]["id"].to_i).to eq(merchant_2.id)
  end

  describe "business intelligence endpoints for a single Merchant" do
    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)

      @item_1 = create(:item, unit_price: 1000)
      @item_2 = create(:item, unit_price: 2000)
      @item_3 = create(:item, unit_price: 3000)
      @item_4 = create(:item, unit_price: 4000)
      @item_5 = create(:item, unit_price: 5000)
      @item_6 = create(:item, unit_price: 6000)
      @item_7 = create(:item, unit_price: 7000)
      @item_8 = create(:item, unit_price: 8000)

      @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_3, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_4, created_at: "2012-03-24T14:54:05.000Z")

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

      create(:transaction, invoice: @invoice_1)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create(:transaction, invoice: @invoice_5)

      create(:failed_transaction, invoice: @invoice_6)
      create(:failed_transaction, invoice: @invoice_7)
      create(:failed_transaction, invoice: @invoice_8)
    end

    it "delivers total revenue" do
      get "/api/v1/merchants/#{@merchant.id}/revenue"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]["attributes"]

      expect(merchant["revenue"]).to eq("1210.0")
    end

    it "delivers revenue for a specific date" do
      get "/api/v1/merchants/#{@merchant.id}/revenue?date=2012-03-20"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]["attributes"]

      expect(merchant["revenue"]).to eq("100.0")

      get "/api/v1/merchants/#{@merchant.id}/revenue?date=2012-03-22"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]["attributes"]

      expect(merchant["revenue"]).to eq("1110.0")

      get "/api/v1/merchants/#{@merchant.id}/revenue?date=2012-03-24"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]["attributes"]

      expect(merchant["revenue"]).to eq("0.0")
    end

    it "delivers the Merchant's favorite customer" do
      get "/api/v1/merchants/#{@merchant.id}/favorite_customer"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]["attributes"]

      expect(customer["id"]).to eq(@customer_2.id)
    end

    it "delivers the Merchant's customers with pending invoices" do
      get "/api/v1/merchants/#{@merchant.id}/customers_with_pending_invoices"

      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]

      expect(customers[0]["id"].to_i).to eq(@customer_3.id)
      expect(customers[1]["id"].to_i).to eq(@customer_4.id)
    end
  end

  describe "business intelligence endpoints for all Merchants" do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)

      @customer = create(:customer)

      @item_1  = create(:item, unit_price: 1000, merchant: @merchant_1)
      @item_2  = create(:item, unit_price: 2000, merchant: @merchant_1)
      @item_3  = create(:item, unit_price: 3000, merchant: @merchant_2)
      @item_4  = create(:item, unit_price: 4000, merchant: @merchant_2)
      @item_5  = create(:item, unit_price: 5000, merchant: @merchant_3)
      @item_6  = create(:item, unit_price: 6000, merchant: @merchant_3)
      @item_7  = create(:item, unit_price: 7000, merchant: @merchant_4)
      @item_8  = create(:item, unit_price: 8000, merchant: @merchant_4)
      @item_9  = create(:item, unit_price: 9000, merchant: @merchant_5)
      @item_10 = create(:item, unit_price: 1000, merchant: @merchant_5)
      @item_11 = create(:item, unit_price: 2000, merchant: @merchant_6)
      @item_12 = create(:item, unit_price: 3000, merchant: @merchant_6)
      @item_13 = create(:item, unit_price: 4000, merchant: @merchant_7)
      @item_14 = create(:item, unit_price: 5000, merchant: @merchant_7)
      @item_15 = create(:item, unit_price: 6000, merchant: @merchant_8)
      @item_16 = create(:item, unit_price: 7000, merchant: @merchant_8)

      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3  = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_4  = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_5  = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6  = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_7  = create(:invoice, merchant: @merchant_4, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_8  = create(:invoice, merchant: @merchant_4, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_9  = create(:invoice, merchant: @merchant_5, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_10 = create(:invoice, merchant: @merchant_5, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_11 = create(:invoice, merchant: @merchant_6, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_12 = create(:invoice, merchant: @merchant_6, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_13 = create(:invoice, merchant: @merchant_7, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_14 = create(:invoice, merchant: @merchant_7, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_15 = create(:invoice, merchant: @merchant_8, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_16 = create(:invoice, merchant: @merchant_8, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")

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

    it ".most_revenue" do
      get "/api/v1/merchants/most_revenue?quantity=2"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants[0]["id"].to_i).to eq(@merchant_4.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant_5.id)

      get "/api/v1/merchants/most_revenue?quantity=4"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants[0]["id"].to_i).to eq(@merchant_4.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant_5.id)
      expect(merchants[2]["id"].to_i).to eq(@merchant_3.id)
      expect(merchants[3]["id"].to_i).to eq(@merchant_6.id)
    end

    it ".most_items" do
      get "/api/v1/merchants/most_items?quantity=2"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants[0]["id"].to_i).to eq(@merchant_6.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant_5.id)

      get "/api/v1/merchants/most_items?quantity=4"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants[0]["id"].to_i).to eq(@merchant_6.id)
      expect(merchants[1]["id"].to_i).to eq(@merchant_5.id)
      expect(merchants[2]["id"].to_i).to eq(@merchant_4.id)
      expect(merchants[3]["id"].to_i).to eq(@merchant_3.id)
    end

    it ".total_date_revenue" do
      get "/api/v1/merchants/revenue?date=2012-03-20"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]["attributes"]

      expect(merchants["total_revenue"]).to eq("600.0")

      get "/api/v1/merchants/revenue?date=2012-03-22"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]["attributes"]

      expect(merchants["total_revenue"]).to eq("3480.0")

      get "/api/v1/merchants/revenue?date=2012-03-24"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]["attributes"]

      expect(merchants["total_revenue"]).to eq("2980.0")

      get "/api/v1/merchants/revenue?date=2012-03-26"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]["attributes"]

      expect(merchants["total_revenue"]).to eq("0.0")
    end
  end
end
