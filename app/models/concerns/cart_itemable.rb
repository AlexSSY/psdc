module CartItemable
  extend ActiveSupport::Concern

  included do
    has_many :cart_items, as: :cart_itemable, dependent: :restrict_with_exception
  end
end
