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

  it "finds a random Transaction" do
    create_list(:transaction, 4)

    ids = Transaction.pluck(:id)

    get "/api/v1/transactions/random"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(ids).to include(transaction[0]["id"].to_i)
  end

  it "finds a single Transaction by ID" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction_1.id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find?id=#{transaction_2.id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_2.id)
  end

  it "finds a single Transaction by invoice_id" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)

    get "/api/v1/transactions/find?invoice_id=#{transaction_1.invoice_id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find?invoice_id=#{transaction_2.invoice_id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_2.id)
  end

  it "finds a single Transaction by credit_card_number" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{transaction_1.credit_card_number}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find?credit_card_number=#{transaction_2.credit_card_number}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_2.id)
  end

  it "finds a single Transaction by result" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:failed_transaction)

    get "/api/v1/transactions/find?result=#{transaction_1.result}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find?result=#{transaction_2.result}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_2.id)
  end

  it "finds a single Transaction by created_at" do
    transaction_1 = create(:transaction, created_at: "2012-03-20T14:54:05.000Z")
    transaction_2 = create(:transaction, created_at: "2012-03-22T14:54:05.000Z")

    get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]["attributes"]

    expect(transaction["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find?created_at=#{transaction_2.created_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_2.id)
  end

  it "finds a single Transaction by updated_at" do
    transaction_1 = create(:transaction, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    transaction_2 = create(:transaction, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

    get "/api/v1/transactions/find?updated_at=#{transaction_1.updated_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find?updated_at=#{transaction_2.updated_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(transaction_2.id)
  end

  it "finds all Transactions by ID" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find_all?id=#{transaction_1.id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_1.id)

    get "/api/v1/transactions/find_all?id=#{transaction_2.id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_2.id)
  end

  it "finds all Transactions by invoice_id" do
    invoice = create(:invoice)

    transaction_1 = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find_all?invoice_id=#{transaction_1.invoice_id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_1.id)
    expect(transaction[1]["id"].to_i).to eq(transaction_2.id)
  end

  it "finds all Transactions by credit_card_number" do
    transaction_1 = create(:transaction, credit_card_number: "1111111111111111")
    transaction_2 = create(:transaction, credit_card_number: "1111111111111111")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_1.id)
    expect(transaction[1]["id"].to_i).to eq(transaction_2.id)
  end

  it "finds all Transactions by result" do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/find_all?result=#{transaction_1.result}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_1.id)
    expect(transaction[1]["id"].to_i).to eq(transaction_2.id)
  end

  it "finds all Transactions by created_at" do
    transaction_1 = create(:transaction, created_at: "2012-03-20T14:54:05.000Z")
    transaction_2 = create(:transaction, created_at: "2012-03-20T14:54:05.000Z")

    get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_1.id)
    expect(transaction[1]["id"].to_i).to eq(transaction_2.id)
  end

  it "finds all Transactions by updated_at" do
    transaction_1 = create(:transaction, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    transaction_2 = create(:transaction, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

    get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction[0]["id"].to_i).to eq(transaction_1.id)
    expect(transaction[1]["id"].to_i).to eq(transaction_2.id)
  end
end
