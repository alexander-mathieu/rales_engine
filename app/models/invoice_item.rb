class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity,
                        :unit_price

  default_scope { order(id: :asc) }

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
