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
end
