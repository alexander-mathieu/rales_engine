class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def revenue
    invoices
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .take
  end

  def date_revenue(date)
    invoices
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .joins(:items, :transactions)
    .merge(Transaction.successful)
    .where("CAST(invoices.updated_at AS text) LIKE ?", "#{date}%")
    .take
  end

  def customers_with_pending_invoices
    customers
    .joins(:invoices)
    .where.not(invoices: {id: Invoice.paid_invoice_ids})
    .distinct
  end

  def favorite_customer
    customers
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("COUNT(transactions.id) DESC")
    .limit(1)
    .take
  end

  def self.search_by(search_params)
    where(search_params).first
  end

  def self.search_all_by(search_params)
    where(search_params)
  end

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("total_revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS total_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order('total_sold DESC')
    .limit(quantity)
  end

  def self.total_date_revenue(date)
    select("SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .joins(invoices: [:items, :transactions])
    .merge(Transaction.successful)
    .where("CAST(invoices.updated_at AS text) LIKE ?", "#{date}%")
    .take
  end
end
