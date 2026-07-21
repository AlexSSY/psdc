class CheckoutService < ApplicationService
  def initialize(cart:)
    @cart = cart
  end

  def call
  end

  attr_reader :cart
end
