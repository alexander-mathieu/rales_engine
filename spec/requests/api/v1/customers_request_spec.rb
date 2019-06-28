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
end
