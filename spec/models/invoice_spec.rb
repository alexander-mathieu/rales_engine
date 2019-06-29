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
