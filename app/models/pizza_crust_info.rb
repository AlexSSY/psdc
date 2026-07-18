class PizzaCrustInfo < ApplicationRecord
    belongs_to :pizza_size
    belongs_to :pizza_crust
end
