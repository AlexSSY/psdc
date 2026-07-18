class PizzaDough < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :pizza_dough_infos
  has_many :pizzas

  def info_for_size(pizza_size)
    pizza_dough_infos.find_by!(pizza_size: pizza_size)
  end
end
