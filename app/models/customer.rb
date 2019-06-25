class Customer < ApplicationRecord
  has_many :invoices

  validates_presence_of :last_name,
                        :first_name
end
