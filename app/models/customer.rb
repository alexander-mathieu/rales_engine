class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices

  validates_presence_of :last_name,
                        :first_name

  def favorite_merchant
    merchants
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group(:id)
    .order("COUNT(transactions.id) DESC")
    .limit(1)
    .take
  end
end
