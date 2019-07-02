class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  def self.paid_invoice_ids
    joins(:transactions)
    .where(transactions: {result: "success"})
    .group(:id)
    .pluck(:id)
  end
end
