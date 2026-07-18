class PizzaDoughInfo < ApplicationRecord
  belongs_to :pizza_size
  belongs_to :pizza_dough
end
