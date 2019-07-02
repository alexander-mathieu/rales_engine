class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.find_random
    order("RANDOM()")
    .limit(1)
  end

  def self.search_by(search_params)
    search_all_by(search_params).first
  end

  def self.search_all_by(search_params)
    where(search_params)
    .order(id: :asc)
  end
end
