
class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :result,
                        :credit_card_number

  scope :successful, -> { where(result: "success") }

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
