class Customer < ApplicationRecord
  validates :last_name, :first_name, presence: true
end
