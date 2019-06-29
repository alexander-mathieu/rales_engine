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

  describe "class methods" do
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
  end
end
