class Breed < ApplicationRecord
  validates :name, :origin, :common_name, :characteristics, :image, :fun_fact, :variations, :history, presence: true

  scope :origin_search, -> (input) { where("origin like ?", "#{input}")}

  scope :name_search, -> (input) { where("name like ?", "%#{input}%")}
  # scope :search, -> (input) { where("name like ?", "%#{input}%" OR "origin like ?", "%#{input}%")}

# PAGINATION
  paginates_per 10
  max_paginates_per 10
end
