require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :description }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "instance methods" do
    it "#best_day" do
      item_1 = create(:item)
      item_2 = create(:item)

      invoice_1 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      invoice_2 = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      invoice_3 = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      invoice_4 = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      invoice_5 = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      invoice_6 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      invoice_7 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      invoice_8 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")

      create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 40)
      create(:invoice_item, invoice: invoice_2, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_2, item: item_2, quantity: 40)
      create(:invoice_item, invoice: invoice_3, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_3, item: item_2, quantity: 20)
      create(:invoice_item, invoice: invoice_4, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_4, item: item_2, quantity: 20)
      create(:invoice_item, invoice: invoice_5, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_5, item: item_2, quantity: 20)
      create(:invoice_item, invoice: invoice_6, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_6, item: item_2, quantity: 20)
      create(:invoice_item, invoice: invoice_7, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_7, item: item_2, quantity: 20)
      create(:invoice_item, invoice: invoice_8, item: item_1, quantity: 10)
      create(:invoice_item, invoice: invoice_8, item: item_2, quantity: 20)

      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction, invoice: invoice_3)
      create(:transaction, invoice: invoice_4)
      create(:transaction, invoice: invoice_5)

      create(:failed_transaction, invoice: invoice_6)
      create(:failed_transaction, invoice: invoice_7)
      create(:failed_transaction, invoice: invoice_8)

      expect(item_1.best_day.attributes["best_day"]).to eq("2012-03-22T14:54:05.000Z")
      expect(item_2.best_day.attributes["best_day"]).to eq("2012-03-20T14:54:05.000Z")
    end
  end

  describe "class methods" do
    before :each do
      @item_1  = create(:item, unit_price: 1000)
      @item_2  = create(:item, unit_price: 2000)
      @item_3  = create(:item, unit_price: 3000)
      @item_4  = create(:item, unit_price: 4000)
      @item_5  = create(:item, unit_price: 5000)
      @item_6  = create(:item, unit_price: 6000)
      @item_7  = create(:item, unit_price: 7000)
      @item_8  = create(:item, unit_price: 8000)
      @item_9  = create(:item, unit_price: 9000)
      @item_10 = create(:item, unit_price: 1000)
      @item_11 = create(:item, unit_price: 2000)
      @item_12 = create(:item, unit_price: 3000)
      @item_13 = create(:item, unit_price: 4000)
      @item_14 = create(:item, unit_price: 5000)
      @item_15 = create(:item, unit_price: 6000)
      @item_16 = create(:item, unit_price: 7000)

      @invoice_1  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_2  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_3  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_4  = create(:invoice, created_at: "2012-03-20T14:54:05.000Z")
      @invoice_5  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_6  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_7  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_8  = create(:invoice, created_at: "2012-03-22T14:54:05.000Z")
      @invoice_9  = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_10 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_11 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_12 = create(:invoice, created_at: "2012-03-24T14:54:05.000Z")
      @invoice_13 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_14 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_15 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")
      @invoice_16 = create(:invoice, created_at: "2012-03-26T14:54:05.000Z")

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
      expect(Item.most_revenue(4)).to eq([@item_9, @item_8, @item_7, @item_6])
    end

    it ".most_items" do
      expect(Item.most_items(4)).to eq([@item_12, @item_11, @item_10, @item_9])
    end

    it ".search_by" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      item_1 = create(:item, merchant: merchant_1, name: "Item Name 1", unit_price: 1234, description: "Item Description 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      item_2 = create(:item, merchant: merchant_2, name: "Item Name 2", unit_price: 5678, description: "Item Description 2", created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

      expect(Item.search_by({"id"=>"#{item_1.id}"})).to eq(item_1)
      expect(Item.search_by({"id"=>"#{item_2.id}"})).to eq(item_2)

      expect(Item.search_by({"merchant_id"=>"#{item_1.merchant_id}"})).to eq(item_1)
      expect(Item.search_by({"merchant_id"=>"#{item_2.merchant_id}"})).to eq(item_2)

      expect(Item.search_by({"name"=>"#{item_1.name}"})).to eq(item_1)
      expect(Item.search_by({"name"=>"#{item_2.name}"})).to eq(item_2)

      expect(Item.search_by({"unit_price"=>"#{item_1.unit_price}"})).to eq(item_1)
      expect(Item.search_by({"unit_price"=>"#{item_2.unit_price}"})).to eq(item_2)

      expect(Item.search_by({"description"=>"#{item_1.description}"})).to eq(item_1)
      expect(Item.search_by({"description"=>"#{item_2.description}"})).to eq(item_2)

      expect(Item.search_by({"created_at"=>"#{item_1.created_at}"})).to eq(item_1)
      expect(Item.search_by({"created_at"=>"#{item_2.created_at}"})).to eq(item_2)

      expect(Item.search_by({"updated_at"=>"#{item_1.updated_at}"})).to eq(item_1)
      expect(Item.search_by({"updated_at"=>"#{item_2.updated_at}"})).to eq(item_2)
    end

    it ".search_all_by" do
      merchant = create(:merchant)

      item_1 = create(:item, merchant: merchant, name: "Item Name 1", unit_price: 1234, description: "Item Description 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      item_2 = create(:item, merchant: merchant, name: "Item Name 1", unit_price: 1234, description: "Item Description 1", created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

      expect(Item.search_all_by({"id"=>"#{item_1.id}"})).to eq([item_1])
      expect(Item.search_all_by({"id"=>"#{item_2.id}"})).to eq([item_2])

      expect(Item.search_all_by({"merchant_id"=>"#{item_1.merchant_id}"})).to eq([item_1, item_2])
      expect(Item.search_all_by({"name"=>"#{item_1.name}"})).to eq([item_1, item_2])
      expect(Item.search_all_by({"unit_price"=>"#{item_1.unit_price}"})).to eq([item_1, item_2])
      expect(Item.search_all_by({"description"=>"#{item_1.description}"})).to eq([item_1, item_2])
      expect(Item.search_all_by({"created_at"=>"#{item_1.created_at}"})).to eq([item_1, item_2])
      expect(Item.search_all_by({"updated_at"=>"#{item_1.updated_at}"})).to eq([item_1, item_2])
    end

    it ".find_random" do
      create_list(:item, 4)

      ids = Item.pluck(:id)

      expect(ids).to include(Item.find_random.take.id.to_i)
    end
  end
end
