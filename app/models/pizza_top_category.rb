class PizzaTopCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :pizza_tops
end
