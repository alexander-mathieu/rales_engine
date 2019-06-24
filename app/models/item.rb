class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, :unit_price, :description, presence: true
end
