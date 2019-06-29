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

  it "delivers the Item for a single InvoiceItem" do
    item          = create(:item)
    invoice_item  = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful

    invoice_item_item = JSON.parse(response.body)["data"]

    expect(invoice_item_item["id"].to_i).to eq(item.id)
  end

  it "delivers the Invoice for a single InvoiceItem" do
    invoice       = create(:invoice)
    invoice_item  = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful

    invoice_item_invoice = JSON.parse(response.body)["data"]

    expect(invoice_item_invoice["id"].to_i).to eq(invoice.id)
  end

  it "finds a random InvoiceItem" do
    create_list(:invoice_item, 4)

    ids = InvoiceItem.pluck(:id)

    get "/api/v1/invoice_items/random"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(ids).to include(invoice_item[0]["id"].to_i)
  end

  it "finds a single InvoiceItem by ID" do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item_1.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?id=#{invoice_item_2.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds a single InvoiceItem by item_id" do
    item_1 = create(:item)
    item_2 = create(:item)

    invoice_item_1 = create(:invoice_item, item: item_1)
    invoice_item_2 = create(:invoice_item, item: item_2)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item_1.item_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item_2.item_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds a single InvoiceItem by invoice_id" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice: invoice_1)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item_1.invoice_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item_2.invoice_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds a single InvoiceItem by quantity" do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_2.quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds a single InvoiceItem by unit_price" do
    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice: invoice_1)
    invoice_item_2 = create(:invoice_item, invoice: invoice_2)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item_1.unit_price}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item_2.unit_price}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds a single InvoiceItem by created_at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-20T14:54:05.000Z")
    invoice_item_2 = create(:invoice_item, created_at: "2012-03-22T14:54:05.000Z")

    get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]["attributes"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?created_at=#{invoice_item_2.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds a single InvoiceItem by updated_at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    invoice_item_2 = create(:invoice_item, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item_2.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by ID" do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)

    get "/api/v1/invoice_items/find_all?id=#{invoice_item_2.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by item_id" do
    item = create(:item)

    invoice_item_1 = create(:invoice_item, item: item)
    invoice_item_2 = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/find_all?item_id=#{invoice_item_1.item_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_item[1]["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by invoice_id" do
    invoice = create(:invoice)

    invoice_item_1 = create(:invoice_item, invoice: invoice)
    invoice_item_2 = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item_1.invoice_id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_item[1]["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by quantity" do
    invoice_item_1 = create(:invoice_item, quantity: 1234)
    invoice_item_2 = create(:invoice_item, quantity: 1234)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_item[1]["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by unit_price" do
    invoice_item_1 = create(:invoice_item, unit_price: 1234)
    invoice_item_2 = create(:invoice_item, unit_price: 1234)

    get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item_1.unit_price}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_item[1]["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by created_at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-20T14:54:05.000Z")
    invoice_item_2 = create(:invoice_item, created_at: "2012-03-20T14:54:05.000Z")

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_item[1]["id"].to_i).to eq(invoice_item_2.id)
  end

  it "finds all InvoiceItems by updated_at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    invoice_item_2 = create(:invoice_item, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)["data"]

    expect(invoice_item[0]["id"].to_i).to eq(invoice_item_1.id)
    expect(invoice_item[1]["id"].to_i).to eq(invoice_item_2.id)
  end
end
