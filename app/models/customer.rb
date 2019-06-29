class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

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
end
