require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end

  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "class methods" do
    it ".search_by" do
      item_1 = create(:item)
      item_2 = create(:item)

      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1234, unit_price: 1234, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 5678, unit_price: 5678, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

      expect(InvoiceItem.search_by({"id"=>"#{invoice_item_1.id}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"id"=>"#{invoice_item_2.id}"})).to eq(invoice_item_2)

      expect(InvoiceItem.search_by({"item_id"=>"#{invoice_item_1.item_id}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"item_id"=>"#{invoice_item_2.item_id}"})).to eq(invoice_item_2)

      expect(InvoiceItem.search_by({"invoice_id"=>"#{invoice_item_1.invoice_id}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"invoice_id"=>"#{invoice_item_2.invoice_id}"})).to eq(invoice_item_2)

      expect(InvoiceItem.search_by({"quantity"=>"#{invoice_item_1.quantity}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"quantity"=>"#{invoice_item_2.quantity}"})).to eq(invoice_item_2)

      expect(InvoiceItem.search_by({"unit_price"=>"#{invoice_item_1.unit_price}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"unit_price"=>"#{invoice_item_2.unit_price}"})).to eq(invoice_item_2)

      expect(InvoiceItem.search_by({"created_at"=>"#{invoice_item_1.created_at}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"created_at"=>"#{invoice_item_2.created_at}"})).to eq(invoice_item_2)

      expect(InvoiceItem.search_by({"updated_at"=>"#{invoice_item_1.updated_at}"})).to eq(invoice_item_1)
      expect(InvoiceItem.search_by({"updated_at"=>"#{invoice_item_2.updated_at}"})).to eq(invoice_item_2)
    end

    it ".search_all_by" do
      item    = create(:item)
      invoice = create(:invoice)

      invoice_item_1 = create(:invoice_item, item: item, invoice: invoice, quantity: 1234, unit_price: 1234, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      invoice_item_2 = create(:invoice_item, item: item, invoice: invoice, quantity: 1234, unit_price: 1234, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

      expect(InvoiceItem.search_all_by({"id"=>"#{invoice_item_1.id}"})).to eq([invoice_item_1])
      expect(InvoiceItem.search_all_by({"id"=>"#{invoice_item_2.id}"})).to eq([invoice_item_2])

      expect(InvoiceItem.search_all_by({"item_id"=>"#{invoice_item_1.item_id}"})).to eq([invoice_item_1, invoice_item_2])
      expect(InvoiceItem.search_all_by({"invoice_id"=>"#{invoice_item_1.invoice_id}"})).to eq([invoice_item_1, invoice_item_2])
      expect(InvoiceItem.search_all_by({"quantity"=>"#{invoice_item_1.quantity}"})).to eq([invoice_item_1, invoice_item_2])
      expect(InvoiceItem.search_all_by({"unit_price"=>"#{invoice_item_1.unit_price}"})).to eq([invoice_item_1, invoice_item_2])
      expect(InvoiceItem.search_all_by({"created_at"=>"#{invoice_item_1.created_at}"})).to eq([invoice_item_1, invoice_item_2])
      expect(InvoiceItem.search_all_by({"updated_at"=>"#{invoice_item_1.updated_at}"})).to eq([invoice_item_1, invoice_item_2])
    end

    it ".find_random" do
      create_list(:invoice_item, 4)

      ids = InvoiceItem.pluck(:id)

      expect(ids).to include(InvoiceItem.find_random.take.id.to_i)
    end
  end
end
