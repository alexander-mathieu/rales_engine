class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :result,
                        :credit_card_number

  scope :successful, -> { where(result: "success") }
end
