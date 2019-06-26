class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"}, invoices: {status: "shipped"})
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end
end
