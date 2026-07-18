class PizzaSize < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :pizzas
end
