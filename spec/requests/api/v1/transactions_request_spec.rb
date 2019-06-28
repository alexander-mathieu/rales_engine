require 'rails_helper'

RSpec.describe "Transactions API" do
  it "delivers a list of all Transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(3)
  end

  it "delivers a single Transaction by ID" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(id)
  end

  it "delivers the Invoice for a single Transaction" do
    invoice      = create(:invoice)
    transaction  = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_successful

    transaction_invoice = JSON.parse(response.body)["data"]

    expect(transaction_invoice["id"].to_i).to eq(invoice.id)
  end
end
