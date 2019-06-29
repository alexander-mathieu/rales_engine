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
end
