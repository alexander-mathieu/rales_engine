require 'rails_helper'

RSpec.describe "InvoiceItem API" do
  it "delivers a list of all InvoiceItem" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]

    expect(invoice_items.count).to eq(3)
  end

  it "delivers a single InvoiceItem by ID" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(id)
  end
end
