class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :unit_price,
                        :description

  def self.most_revenue(quantity)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    select("items.*,  SUM(invoice_items.quantity) AS total_sold")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("total_sold DESC")
    .limit(quantity)
  end
end
