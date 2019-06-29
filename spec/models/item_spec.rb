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

  describe "class methods" do
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
