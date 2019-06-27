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

  it "delivers the Merchant for a single Invoice" do
    merchant = create(:merchant)
    invoice  = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    expect(response).to be_successful

    invoice_merchant = JSON.parse(response.body)["data"]

    expect(invoice_merchant["id"].to_i).to eq(merchant.id)
  end
end
