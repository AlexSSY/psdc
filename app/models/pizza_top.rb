class PizzaTop < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :pizza_top_category
  has_one_attached :image
end
