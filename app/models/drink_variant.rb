class DrinkVariant < ApplicationRecord
  include CartItemable

  belongs_to :drink

  delegate :detail_image, to: :drink
end
