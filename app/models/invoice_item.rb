class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity,
                        :unit_price

  scope :id_sort_asc, -> { order(id: :asc) }

  def self.find_random
    order("RANDOM()")
    .limit(1)
  end

  def self.search_by(search_params)
    where(search_params)
    .merge(InvoiceItem.id_sort_asc)
    .first
  end

  def self.search_all_by(search_params)
    where(search_params)
    .merge(InvoiceItem.id_sort_asc)
  end
end
