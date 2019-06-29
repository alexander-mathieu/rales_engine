require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe "instance methods" do
    it ".search_by" do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      customer_1 = create(:customer)
      customer_2 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant_2, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

      expect(Invoice.search_by({"id"=>"#{invoice_1.id}"})).to eq(invoice_1)
      expect(Invoice.search_by({"id"=>"#{invoice_2.id}"})).to eq(invoice_2)

      expect(Invoice.search_by({"customer_id"=>"#{invoice_1.customer_id}"})).to eq(invoice_1)
      expect(Invoice.search_by({"customer_id"=>"#{invoice_2.customer_id}"})).to eq(invoice_2)

      expect(Invoice.search_by({"merchant_id"=>"#{invoice_1.merchant_id}"})).to eq(invoice_1)
      expect(Invoice.search_by({"merchant_id"=>"#{invoice_2.merchant_id}"})).to eq(invoice_2)

      expect(Invoice.search_by({"status"=>"#{invoice_1.status}"})).to eq(invoice_1)

      expect(Invoice.search_by({"created_at"=>"#{invoice_1.created_at}"})).to eq(invoice_1)
      expect(Invoice.search_by({"created_at"=>"#{invoice_2.created_at}"})).to eq(invoice_2)

      expect(Invoice.search_by({"updated_at"=>"#{invoice_1.updated_at}"})).to eq(invoice_1)
      expect(Invoice.search_by({"updated_at"=>"#{invoice_2.updated_at}"})).to eq(invoice_2)
    end

    it ".search_all_by" do
      merchant_1 = create(:merchant)
      customer_1 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_1, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

      expect(Invoice.search_all_by({"id"=>"#{invoice_1.id}"})).to eq([invoice_1])
      expect(Invoice.search_all_by({"id"=>"#{invoice_2.id}"})).to eq([invoice_2])

      expect(Invoice.search_all_by({"customer_id"=>"#{invoice_1.customer_id}"})).to eq([invoice_1, invoice_2])
      expect(Invoice.search_all_by({"merchant_id"=>"#{invoice_1.merchant_id}"})).to eq([invoice_1, invoice_2])
      expect(Invoice.search_all_by({"status"=>"#{invoice_1.status}"})).to eq([invoice_1, invoice_2])
      expect(Invoice.search_all_by({"created_at"=>"#{invoice_1.created_at}"})).to eq([invoice_1, invoice_2])
      expect(Invoice.search_all_by({"updated_at"=>"#{invoice_1.updated_at}"})).to eq([invoice_1, invoice_2])
    end

    it ".find_random" do
      create_list(:invoice, 4)

      ids = Invoice.pluck(:id)

      expect(ids).to include(Invoice.find_random.take.id.to_i)
    end

    it "#paid_invoice_ids" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      invoice_3 = create(:invoice)
      invoice_4 = create(:invoice)
      invoice_5 = create(:invoice)
      invoice_6 = create(:invoice)
      invoice_7 = create(:invoice)
      invoice_8 = create(:invoice)

      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)

      create(:failed_transaction, invoice: invoice_3)
      create(:failed_transaction, invoice: invoice_4)
      create(:failed_transaction, invoice: invoice_5)
      create(:failed_transaction, invoice: invoice_6)
      create(:failed_transaction, invoice: invoice_7)
      create(:failed_transaction, invoice: invoice_8)

      expect(Invoice.paid_invoice_ids).to eq([invoice_1.id, invoice_2.id])
    end
  end
end
