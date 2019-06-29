require 'rails_helper'

RSpec.describe "Customers API" do
  it "delivers a list of all Customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]

    expect(customers.count).to eq(3)
  end

  it "delivers a single Customer by ID" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(id)
  end

  it "delivers all Invoices for a single Customer" do
    customer = create(:customer)

    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    invoice_3 = create(:invoice, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_successful

    customer_invoices = JSON.parse(response.body)["data"]

    expect(customer_invoices[0]["id"].to_i).to eq(invoice_1.id)
    expect(customer_invoices[1]["id"].to_i).to eq(invoice_2.id)
    expect(customer_invoices[2]["id"].to_i).to eq(invoice_3.id)
  end

  it "delivers all Transactions for a single Customer" do
    customer = create(:customer)

    invoice_1 = create(:invoice, customer: customer)
    invoice_2 = create(:invoice, customer: customer)
    invoice_3 = create(:invoice, customer: customer)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_successful

    customer_transactions = JSON.parse(response.body)["data"]

    expect(customer_transactions[0]["id"].to_i).to eq(transaction_1.id)
    expect(customer_transactions[1]["id"].to_i).to eq(transaction_2.id)
    expect(customer_transactions[2]["id"].to_i).to eq(transaction_3.id)
  end

  it "finds a random Customer" do
    create_list(:customer, 4)

    ids = Customer.pluck(:id)

    get "/api/v1/customers/random"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(ids).to include(customer[0]["id"].to_i)

    get "/api/v1/customers/random"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(ids).to include(customer[0]["id"].to_i)
  end

  it "finds a single Customer by ID" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find?id=#{customer_1.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_1.id)

    get "/api/v1/customers/find?id=#{customer_2.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_2.id)
  end

  it "finds a single Customer by first_name" do
    customer_1 = create(:customer, first_name: "First Name 1")
    customer_2 = create(:customer, first_name: "First Name 2")

    get "/api/v1/customers/find?first_name=#{customer_1.first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_1.id)

    get "/api/v1/customers/find?first_name=#{customer_2.first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_2.id)
  end

  it "finds a single Customer by last_name" do
    customer_1 = create(:customer, last_name: "Last Name 1")
    customer_2 = create(:customer, last_name: "Last Name 2")

    get "/api/v1/customers/find?last_name=#{customer_1.last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_1.id)

    get "/api/v1/customers/find?last_name=#{customer_2.last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_2.id)
  end

  it "finds a single Customer by created_at" do
    customer_1 = create(:customer, created_at: "2012-03-20T14:54:05.000Z")
    customer_2 = create(:customer, created_at: "2012-03-22T14:54:05.000Z")

    get "/api/v1/customers/find?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]["attributes"]

    expect(customer["id"].to_i).to eq(customer_1.id)

    get "/api/v1/customers/find?created_at=#{customer_2.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_2.id)
  end

  it "finds a single Customer by updated_at" do
    customer_1 = create(:customer, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    customer_2 = create(:customer, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

    get "/api/v1/customers/find?updated_at=#{customer_1.updated_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_1.id)

    get "/api/v1/customers/find?updated_at=#{customer_2.updated_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer["id"].to_i).to eq(customer_2.id)
  end

  it "finds all Customers by ID" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer_1.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)

    get "/api/v1/customers/find_all?id=#{customer_2.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_2.id)
  end

  it "finds all Customers by first_name" do
    customer_1 = create(:customer, first_name: "First Name 1")
    customer_2 = create(:customer, first_name: "First Name 1")

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)
  end

  it "finds all Customers by last_name" do
    customer_1 = create(:customer, last_name: "First Name 1")
    customer_2 = create(:customer, last_name: "First Name 1")

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)
  end

  it "finds all Customers by created_at" do
    customer_1 = create(:customer, created_at: "2012-03-20T14:54:05.000Z")
    customer_2 = create(:customer, created_at: "2012-03-20T14:54:05.000Z")

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)
  end

  it "finds all Customers by updated_at" do
    customer_1 = create(:customer, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
    customer_2 = create(:customer, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)["data"]

    expect(customer[0]["id"].to_i).to eq(customer_1.id)
    expect(customer[1]["id"].to_i).to eq(customer_2.id)
  end
end
