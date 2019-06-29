class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  default_scope { order(id: :asc) }

  def self.search_by(search_params)
    where(search_params).first
  end

  def self.find_random
    order("RANDOM()")
    .limit(1)
  end

  def self.search_all_by(search_params)
    where(search_params)
  end

  def self.paid_invoice_ids
    joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .pluck(:id)
  end
end
