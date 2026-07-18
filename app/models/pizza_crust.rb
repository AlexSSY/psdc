class PizzaCrust < ApplicationRecord
  validates_uniqueness_of :name
  validates_presence_of :name

  has_many :pizza_crust_infos
  has_many :pizzas

  def info_for_size(pizza_size)
    pizza_crust_infos.find_by!(pizza_size: pizza_size)
  end
end
