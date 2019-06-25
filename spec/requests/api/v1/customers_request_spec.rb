require 'rails_helper'

RSpec.describe "Customers API" do
  it "delivers a list of all Customers" do
    create_list(:customer, 3)

    get "/api/v1/customers.json"

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]

    expect(customers.count).to eq(3)
  end

  it "delivers a single Customer by ID" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}.json"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(id)
  end
end
