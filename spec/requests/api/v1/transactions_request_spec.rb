require 'rails_helper'

RSpec.describe "Transactions API" do
  it "delivers a list of all Transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions.json"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(3)
  end

  it "delivers a single Transaction by ID" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}.json"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)["data"]

    expect(transaction["id"].to_i).to eq(id)
  end
end
