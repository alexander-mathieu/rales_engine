require 'rails_helper'

RSpec.describe "Invoices API" do
  it "delivers a list of all Invoices" do
    create_list(:invoice, 3)

    get "/api/v1/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]

    expect(invoices.count).to eq(3)
  end

  it "delivers a single Invoice by ID" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(id)
  end

  it "delivers all Items for a single Invoice" do
    merchant = create(:merchant)

    invoice = create(:invoice, merchant: merchant)

    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    create(:invoice_item, invoice: invoice, item: item_1)
    create(:invoice_item, invoice: invoice, item: item_2)
    create(:invoice_item, invoice: invoice, item: item_3)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items[0]["id"].to_i).to eq(item_1.id)
    expect(invoice_items[1]["id"].to_i).to eq(item_2.id)
    expect(invoice_items[2]["id"].to_i).to eq(item_3.id)
  end

  it "delivers all Transactions for a single Invoice" do
    merchant = create(:merchant)

    invoice = create(:invoice, merchant: merchant)

    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    create(:invoice_item, invoice: invoice, item: item_1)
    create(:invoice_item, invoice: invoice, item: item_2)
    create(:invoice_item, invoice: invoice, item: item_3)

    transaction_1 = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice)
    transaction_3 = create(:transaction, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_successful

    invoice_transactions = JSON.parse(response.body)["data"]

    expect(invoice_transactions[0]["id"].to_i).to eq(transaction_1.id)
    expect(invoice_transactions[1]["id"].to_i).to eq(transaction_2.id)
    expect(invoice_transactions[2]["id"].to_i).to eq(transaction_3.id)
  end

  it "delivers all InvoiceItems for a single Invoice" do
    merchant = create(:merchant)

    invoice = create(:invoice, merchant: merchant)

    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)

    invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
    invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_2)
    invoice_item_3 = create(:invoice_item, invoice: invoice, item: item_3)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_successful

    invoice_invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_invoice_items[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_invoice_items[1]["id"].to_i).to eq(invoice_item_2.id)
    expect(invoice_invoice_items[2]["id"].to_i).to eq(invoice_item_3.id)
  end

  it "delivers the Customer for a single Invoice" do
    customer = create(:customer)
    invoice  = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"

    expect(response).to be_successful

    invoice_customer = JSON.parse(response.body)["data"]

    expect(invoice_customer["id"].to_i).to eq(customer.id)
  end

  it "delivers the Merchant for a single Invoice" do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    invoice_merchant = JSON.parse(response.body)["data"]

    expect(invoice_merchant["id"].to_i).to eq(merchant.id)
  end

  it "finds a random Invoice" do
    create_list(:invoice, 4)

    ids = Invoice.pluck(:id)

    get "/api/v1/invoices/random"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(ids).to include(invoice[0]["id"].to_i)
  end

  it "finds a single Invoice by ID" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_1.id)

    get "/api/v1/invoices/find?id=#{invoice_2.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_2.id)
  end

  it "finds a single Invoice by customer_id" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    invoice_1 = create(:invoice, customer: customer_1)
    invoice_2 = create(:invoice, customer: customer_2)

    get "/api/v1/invoices/find?customer_id=#{invoice_1.customer_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_1.id)

    get "/api/v1/invoices/find?customer_id=#{invoice_2.customer_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_2.id)
  end

  it "finds a single Invoice by merchant_id" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    invoice_1 = create(:invoice, merchant: merchant_1)
    invoice_2 = create(:invoice, merchant: merchant_2)

    get "/api/v1/invoices/find?merchant_id=#{invoice_1.merchant_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_1.id)

    get "/api/v1/invoices/find?merchant_id=#{invoice_2.merchant_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_2.id)
  end

  it "finds a single Invoice by status" do
    invoice_1 = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice_1.status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_1.id)
  end

  it "finds a single Invoice by created_at" do
    invoice_1 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
    invoice_2 = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")

    get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]["attributes"]

    expect(invoice["id"].to_i).to eq(invoice_1.id)

    get "/api/v1/invoices/find?created_at=#{invoice_2.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_2.id)
  end

  it "finds a single Invoice by updated_at" do
    invoice_1 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    invoice_2 = create(:invoice, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

    get "/api/v1/invoices/find?updated_at=#{invoice_1.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_1.id)

    get "/api/v1/invoices/find?updated_at=#{invoice_2.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice["id"].to_i).to eq(invoice_2.id)
  end

  it "finds all Invoices by ID" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find_all?id=#{invoice_1.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_1.id)

    get "/api/v1/invoices/find_all?id=#{invoice_2.id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_2.id)
  end

  it "finds all Invoices by customer_id" do
    customer = create(:customer)

    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)

    get "/api/v1/invoices/find_all?customer_id=#{invoice_1.customer_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_1.id)
    expect(invoice[1]["id"].to_i).to eq(invoice_2.id)
  end

  it "finds all Invoices by merchant_id" do
    merchant = create(:merchant)

    invoice_1 = create(:invoice, merchant: merchant)
    invoice_2 = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/find_all?merchant_id=#{invoice_1.merchant_id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_1.id)
    expect(invoice[1]["id"].to_i).to eq(invoice_2.id)
  end

  it "finds all Invoices by status" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    get "/api/v1/invoices/find_all?status=#{invoice_1.status}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_1.id)
    expect(invoice[1]["id"].to_i).to eq(invoice_2.id)
  end

  it "finds all Invoices by created_at" do
    invoice_1 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
    invoice_2 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")

    get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_1.id)
    expect(invoice[1]["id"].to_i).to eq(invoice_2.id)
  end

  it "finds all Invoices by updated_at" do
    invoice_1 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    invoice_2 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

    get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)["data"]

    expect(invoice[0]["id"].to_i).to eq(invoice_1.id)
    expect(invoice[1]["id"].to_i).to eq(invoice_2.id)
  end
end
