class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates_presence_of :name

  scope :default_sort, -> { order(name: :asc) }

  def self.most_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .where(invoices: {status: "shipped"}, transactions: {result: "success"})
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS total_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .where(invoices: {status: "shipped"}, transactions: {result: "success"})
    .group(:id)
    .order('total_sold DESC')
    .limit(quantity)
  end
end
