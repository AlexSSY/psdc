class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_cart
  helper_method :current_cart

  private

  def current_cart
    @cart
  end

  def set_cart
    @cart = load_from_session || create_and_store_in_session
    Current.cart = @cart
  end

  def load_from_session
    Cart.includes(:cart_items).find_by(id: session[:cart_id])
  end

  def create_and_store_in_session
    Cart.create!.tap { |cart| session[:cart_id] = cart.id }
  end
end
