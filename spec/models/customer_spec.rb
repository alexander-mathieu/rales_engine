require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :first_name }
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "instance methods" do
    it "#favorite_merchant" do
      customer = create(:customer)

      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)

      invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_4 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_5 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_6 = create(:invoice, customer: customer, merchant: merchant_3)
      invoice_7 = create(:invoice, customer: customer, merchant: merchant_4)
      invoice_8 = create(:invoice, customer: customer, merchant: merchant_4)

      transaction_1 = create(:transaction, invoice: invoice_1)
      transaction_2 = create(:transaction, invoice: invoice_2)
      transaction_3 = create(:transaction, invoice: invoice_3)
      transaction_4 = create(:transaction, invoice: invoice_4)
      transaction_5 = create(:transaction, invoice: invoice_5)
      transaction_6 = create(:transaction, invoice: invoice_6)
      transaction_7 = create(:transaction, invoice: invoice_7)
      transaction_8 = create(:transaction, invoice: invoice_8)

      expect(customer.favorite_merchant).to eq(merchant_2)
    end
  end

  describe "class methods" do
    it ".search_by" do
      customer_1 = create(:customer, first_name: "First Name 1", last_name: "Last Name 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      customer_2 = create(:customer, first_name: "First Name 2", last_name: "Last Name 2", created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

      expect(Customer.search_by({"id"=>"#{customer_1.id}"})).to eq(customer_1)
      expect(Customer.search_by({"id"=>"#{customer_2.id}"})).to eq(customer_2)

      expect(Customer.search_by({"first_name"=>"#{customer_1.first_name}"})).to eq(customer_1)
      expect(Customer.search_by({"first_name"=>"#{customer_2.first_name}"})).to eq(customer_2)

      expect(Customer.search_by({"last_name"=>"#{customer_1.last_name}"})).to eq(customer_1)
      expect(Customer.search_by({"last_name"=>"#{customer_2.last_name}"})).to eq(customer_2)

      expect(Customer.search_by({"created_at"=>"#{customer_1.created_at}"})).to eq(customer_1)
      expect(Customer.search_by({"created_at"=>"#{customer_2.created_at}"})).to eq(customer_2)

      expect(Customer.search_by({"updated_at"=>"#{customer_1.updated_at}"})).to eq(customer_1)
      expect(Customer.search_by({"updated_at"=>"#{customer_2.updated_at}"})).to eq(customer_2)
    end

    it ".search_all_by" do
      customer_1 = create(:customer, first_name: "First Name 1", last_name: "Last Name 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      customer_2 = create(:customer, first_name: "First Name 1", last_name: "Last Name 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

      expect(Customer.search_all_by({"id"=>"#{customer_1.id}"})).to eq([customer_1])
      expect(Customer.search_all_by({"id"=>"#{customer_2.id}"})).to eq([customer_2])

      expect(Customer.search_all_by({"first_name"=>"#{customer_1.first_name}"})).to eq([customer_1, customer_2])
      expect(Customer.search_all_by({"last_name"=>"#{customer_1.last_name}"})).to eq([customer_1, customer_2])
      expect(Customer.search_all_by({"created_at"=>"#{customer_1.created_at}"})).to eq([customer_1, customer_2])
      expect(Customer.search_all_by({"updated_at"=>"#{customer_1.updated_at}"})).to eq([customer_1, customer_2])
    end

    it ".find_random" do
      create_list(:customer, 4)

      ids = Customer.pluck(:id)

      expect(ids).to include(Customer.find_random.take.id.to_i)
    end
  end
end
