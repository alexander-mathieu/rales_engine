class Customer < ApplicationRecord
  has_many :invoices
  
  validates :last_name, :first_name, presence: true
end
