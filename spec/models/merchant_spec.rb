require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "instance methods" do
    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)

      @item_1 = create(:item, unit_price: 1000)
      @item_2 = create(:item, unit_price: 2000)
      @item_3 = create(:item, unit_price: 3000)
      @item_4 = create(:item, unit_price: 4000)
      @item_5 = create(:item, unit_price: 5000)
      @item_6 = create(:item, unit_price: 6000)
      @item_7 = create(:item, unit_price: 7000)
      @item_8 = create(:item, unit_price: 8000)

      @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_2, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_3, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_7 = create(:invoice, merchant: @merchant, customer: @customer_4, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_8 = create(:invoice, merchant: @merchant, customer: @customer_4, created_at: "2012-03-24T14:54:05.000Z")

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_8, item: @item_8, quantity: 8, unit_price: 8000)

      create(:transaction, invoice: @invoice_1)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create(:transaction, invoice: @invoice_5)

      create(:failed_transaction, invoice: @invoice_6)
      create(:failed_transaction, invoice: @invoice_7)
      create(:failed_transaction, invoice: @invoice_8)
    end

    it "#revenue" do
      expect(@merchant.revenue.attributes["revenue"]).to eq(121000)
    end

    it "#date_revenue" do
      expect(@merchant.date_revenue("2012-03-20").attributes["revenue"]).to eq(10000)
      expect(@merchant.date_revenue("2012-03-22").attributes["revenue"]).to eq(111000)
      expect(@merchant.date_revenue("2012-03-24").attributes["revenue"]).to eq(nil)
    end

    it "#favorite_customer" do
      expect(@merchant.favorite_customer).to eq(@customer_2)
    end

    it "#customers_with_pending_invoices" do
      expect(@merchant.customers_with_pending_invoices).to eq([@customer_3, @customer_4])
    end
  end

  describe "class methods" do
    before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
      @merchant_8 = create(:merchant)

      @customer = create(:customer)

      @item_1  = create(:item, unit_price: 1000, merchant: @merchant_1)
      @item_2  = create(:item, unit_price: 2000, merchant: @merchant_1)
      @item_3  = create(:item, unit_price: 3000, merchant: @merchant_2)
      @item_4  = create(:item, unit_price: 4000, merchant: @merchant_2)
      @item_5  = create(:item, unit_price: 5000, merchant: @merchant_3)
      @item_6  = create(:item, unit_price: 6000, merchant: @merchant_3)
      @item_7  = create(:item, unit_price: 7000, merchant: @merchant_4)
      @item_8  = create(:item, unit_price: 8000, merchant: @merchant_4)
      @item_9  = create(:item, unit_price: 9000, merchant: @merchant_5)
      @item_10 = create(:item, unit_price: 1000, merchant: @merchant_5)
      @item_11 = create(:item, unit_price: 2000, merchant: @merchant_6)
      @item_12 = create(:item, unit_price: 3000, merchant: @merchant_6)
      @item_13 = create(:item, unit_price: 4000, merchant: @merchant_7)
      @item_14 = create(:item, unit_price: 5000, merchant: @merchant_7)
      @item_15 = create(:item, unit_price: 6000, merchant: @merchant_8)
      @item_16 = create(:item, unit_price: 7000, merchant: @merchant_8)

      @invoice_1  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3  = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_4  = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_5  = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6  = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_7  = create(:invoice, merchant: @merchant_4, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_8  = create(:invoice, merchant: @merchant_4, customer: @customer, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_9  = create(:invoice, merchant: @merchant_5, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_10 = create(:invoice, merchant: @merchant_5, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_11 = create(:invoice, merchant: @merchant_6, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_12 = create(:invoice, merchant: @merchant_6, customer: @customer, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_13 = create(:invoice, merchant: @merchant_7, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_14 = create(:invoice, merchant: @merchant_7, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_15 = create(:invoice, merchant: @merchant_8, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_16 = create(:invoice, merchant: @merchant_8, customer: @customer, created_at: "2012-03-26T14:54:05.000Z")

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 1, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 2, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 3, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 4, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 5, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 6, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 7, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_8, item: @item_8, quantity: 8, unit_price: 8000)
      create(:invoice_item, invoice: @invoice_9, item: @item_9, quantity: 9, unit_price: 9000)
      create(:invoice_item, invoice: @invoice_9, item: @item_10, quantity: 10, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_10, item: @item_9, quantity: 9, unit_price: 9000)
      create(:invoice_item, invoice: @invoice_10, item: @item_10, quantity: 10, unit_price: 1000)
      create(:invoice_item, invoice: @invoice_11, item: @item_11, quantity: 11, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_11, item: @item_12, quantity: 12, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_12, item: @item_11, quantity: 11, unit_price: 2000)
      create(:invoice_item, invoice: @invoice_12, item: @item_12, quantity: 12, unit_price: 3000)
      create(:invoice_item, invoice: @invoice_13, item: @item_13, quantity: 13, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_13, item: @item_14, quantity: 14, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_14, item: @item_13, quantity: 13, unit_price: 4000)
      create(:invoice_item, invoice: @invoice_14, item: @item_14, quantity: 14, unit_price: 5000)
      create(:invoice_item, invoice: @invoice_15, item: @item_15, quantity: 15, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_15, item: @item_16, quantity: 16, unit_price: 7000)
      create(:invoice_item, invoice: @invoice_16, item: @item_15, quantity: 15, unit_price: 6000)
      create(:invoice_item, invoice: @invoice_16, item: @item_16, quantity: 16, unit_price: 7000)

      create(:transaction, invoice: @invoice_1)
      create(:transaction, invoice: @invoice_2)
      create(:transaction, invoice: @invoice_3)
      create(:transaction, invoice: @invoice_4)
      create(:transaction, invoice: @invoice_5)
      create(:transaction, invoice: @invoice_6)
      create(:transaction, invoice: @invoice_7)
      create(:transaction, invoice: @invoice_8)
      create(:transaction, invoice: @invoice_9)
      create(:transaction, invoice: @invoice_10)
      create(:transaction, invoice: @invoice_11)
      create(:transaction, invoice: @invoice_12)

      create(:failed_transaction, invoice: @invoice_13)
      create(:failed_transaction, invoice: @invoice_14)
      create(:failed_transaction, invoice: @invoice_15)
      create(:failed_transaction, invoice: @invoice_16)
    end

    it ".most_revenue" do
      expect(Merchant.most_revenue(4)).to eq([@merchant_4, @merchant_5, @merchant_3, @merchant_6])
    end

    it ".most_items" do
      expect(Merchant.most_items(4)).to eq([@merchant_6, @merchant_5, @merchant_4, @merchant_3])
    end

    it ".total_date_revenue" do
      expect(Merchant.total_date_revenue("2012-03-20").attributes["total_revenue"]).to eq(60000)
      expect(Merchant.total_date_revenue("2012-03-22").attributes["total_revenue"]).to eq(348000)
      expect(Merchant.total_date_revenue("2012-03-24").attributes["total_revenue"]).to eq(298000)
      expect(Merchant.total_date_revenue("2012-03-26").attributes["total_revenue"]).to eq(nil)
    end

    it ".search_by" do
      merchant_1 = create(:merchant, name: "Merchant Name 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      merchant_2 = create(:merchant, name: "Merchant Name 2", created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

      expect(Merchant.search_by({"id"=>"#{merchant_1.id}"})).to eq(merchant_1)
      expect(Merchant.search_by({"id"=>"#{merchant_2.id}"})).to eq(merchant_2)

      expect(Merchant.search_by({"name"=>"#{merchant_1.name}"})).to eq(merchant_1)
      expect(Merchant.search_by({"name"=>"#{merchant_2.name}"})).to eq(merchant_2)

      expect(Merchant.search_by({"created_at"=>"#{merchant_1.created_at}"})).to eq(merchant_1)
      expect(Merchant.search_by({"created_at"=>"#{merchant_2.created_at}"})).to eq(merchant_2)

      expect(Merchant.search_by({"updated_at"=>"#{merchant_1.updated_at}"})).to eq(merchant_1)
      expect(Merchant.search_by({"updated_at"=>"#{merchant_2.updated_at}"})).to eq(merchant_2)
    end

    it ".search_all_by" do
      merchant_1 = create(:merchant, name: "Merchant Name 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      merchant_2 = create(:merchant, name: "Merchant Name 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

      expect(Merchant.search_all_by({"id"=>"#{merchant_1.id}"})).to eq([merchant_1])
      expect(Merchant.search_all_by({"id"=>"#{merchant_2.id}"})).to eq([merchant_2])

      expect(Merchant.search_all_by({"name"=>"#{merchant_1.name}"})).to eq([merchant_1, merchant_2])
      expect(Merchant.search_all_by({"created_at"=>"#{merchant_1.created_at}"})).to eq([merchant_1, merchant_2])
      expect(Merchant.search_all_by({"updated_at"=>"#{merchant_1.updated_at}"})).to eq([merchant_1, merchant_2])
    end

    it ".find_random" do
      create_list(:merchant, 4)

      ids = Merchant.pluck(:id)

      expect(ids).to include(Merchant.find_random.take.id.to_i)
    end
  end
end
