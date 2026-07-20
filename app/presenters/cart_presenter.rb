class CartPresenter < Keynote::Presenter
  presents :cart

  def items_count
    cart.cart_items.sum(:quantity)
  end
end
