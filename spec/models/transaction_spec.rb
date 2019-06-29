require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_presence_of :result }
    it { should validate_presence_of :credit_card_number }
  end

  describe "relationships" do
    it { should belong_to :invoice }
  end

  describe "class methods" do
    it ".search_by" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      transaction_1 = create(:transaction, invoice: invoice_1, created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      transaction_2 = create(:failed_transaction, invoice: invoice_2, created_at: "2012-03-22T14:54:05.000Z", updated_at: "2012-03-26T14:54:05.000Z")

      expect(Transaction.search_by({"id"=>"#{transaction_1.id}"})).to eq(transaction_1)
      expect(Transaction.search_by({"id"=>"#{transaction_2.id}"})).to eq(transaction_2)

      expect(Transaction.search_by({"invoice_id"=>"#{transaction_1.invoice_id}"})).to eq(transaction_1)
      expect(Transaction.search_by({"invoice_id"=>"#{transaction_2.invoice_id}"})).to eq(transaction_2)

      expect(Transaction.search_by({"credit_card_number"=>"#{transaction_1.credit_card_number}"})).to eq(transaction_1)
      expect(Transaction.search_by({"credit_card_number"=>"#{transaction_2.credit_card_number}"})).to eq(transaction_2)

      expect(Transaction.search_by({"result"=>"#{transaction_1.result}"})).to eq(transaction_1)
      expect(Transaction.search_by({"result"=>"#{transaction_2.result}"})).to eq(transaction_2)

      expect(Transaction.search_by({"created_at"=>"#{transaction_1.created_at}"})).to eq(transaction_1)
      expect(Transaction.search_by({"created_at"=>"#{transaction_2.created_at}"})).to eq(transaction_2)

      expect(Transaction.search_by({"updated_at"=>"#{transaction_1.updated_at}"})).to eq(transaction_1)
      expect(Transaction.search_by({"updated_at"=>"#{transaction_2.updated_at}"})).to eq(transaction_2)
    end

    it ".search_all_by" do
      invoice = create(:invoice)

      transaction_1 = create(:transaction, invoice: invoice, credit_card_number: "1111111111111111",created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")
      transaction_2 = create(:transaction, invoice: invoice, credit_card_number: "1111111111111111",created_at: "2012-03-20T14:54:05.000Z", updated_at: "2012-03-28T14:54:05.000Z")

      expect(Transaction.search_all_by({"id"=>"#{transaction_1.id}"})).to eq([transaction_1])
      expect(Transaction.search_all_by({"id"=>"#{transaction_2.id}"})).to eq([transaction_2])

      expect(Transaction.search_all_by({"invoice_id"=>"#{transaction_1.invoice_id}"})).to eq([transaction_1, transaction_2])
      expect(Transaction.search_all_by({"credit_card_number"=>"#{transaction_1.credit_card_number}"})).to eq([transaction_1, transaction_2])
      expect(Transaction.search_all_by({"result"=>"#{transaction_1.result}"})).to eq([transaction_1, transaction_2])
      expect(Transaction.search_all_by({"created_at"=>"#{transaction_1.created_at}"})).to eq([transaction_1, transaction_2])
      expect(Transaction.search_all_by({"updated_at"=>"#{transaction_1.updated_at}"})).to eq([transaction_1, transaction_2])
    end

    it ".find_random" do
      create_list(:transaction, 4)

      ids = Transaction.pluck(:id)

      expect(ids).to include(Transaction.find_random.take.id.to_i)
    end
  end
end
