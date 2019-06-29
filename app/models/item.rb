class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :unit_price,
                        :description

  scope :id_sort_asc, -> { order(id: :asc) }

  def best_day
    invoices
    .select("invoices.created_at AS best_day, SUM(invoice_items.quantity) AS total_sold")
    .joins(:transactions)
    .merge(Transaction.successful)
    .group(:created_at)
    .order("total_sold DESC, best_day DESC")
    .take
  end

  def self.find_random
    order("RANDOM()")
    .limit(1)
  end

  def self.search_by(search_params)
    where(search_params)
    .merge(Item.id_sort_asc)
    .first
  end

  def self.search_all_by(search_params)
    where(search_params)
    .merge(Item.id_sort_asc)
  end

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
