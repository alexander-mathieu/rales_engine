require 'rails_helper'

RSpec.describe "Items API" do
  it "delivers a list of all Items" do
    create_list(:item, 3)

    get "/api/v1/items.json"

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]

    expect(items.count).to eq(3)
  end

  it "delivers a single Item by ID" do
    id = create(:item).id

    get "/api/v1/items/#{id}.json"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    expect(item["id"].to_i).to eq(id)
  end
end
