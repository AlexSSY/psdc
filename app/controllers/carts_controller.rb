class CartsController < ApplicationController
  def show
    @cart = current_cart
    respond_to do |format|
      format.turbo_stream
    end
  end

  def clear
    @cart_items = current_cart.cart_items.to_a
    current_cart.cart_items.destroy_all
    respond_to do |format|
      format.turbo_stream
    end
  end
end
