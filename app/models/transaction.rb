
class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :result,
                        :credit_card_number

  scope :id_sort_asc, -> { order(id: :asc) }
  scope :successful, -> { where(result: "success") }

  def self.find_random
    order("RANDOM()")
    .limit(1)
  end

  def self.search_by(search_params)
    where(search_params)
    .merge(Transaction.id_sort_asc)
    .first
  end

  def self.search_all_by(search_params)
    where(search_params)
    .merge(Transaction.id_sort_asc)
  end
end
