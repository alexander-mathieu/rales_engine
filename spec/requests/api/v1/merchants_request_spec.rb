require 'rails_helper'

RSpec.describe "Merchants API" do
  it "delivers a list of all Merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants.json"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)["data"]

    expect(merchants.count).to eq(3)
  end

  it "delivers a single Merchant by ID" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)["data"]

    expect(merchant["id"].to_i).to eq(id)
  end
end