# frozen_string_literal: true

class AddButtonComponent < ApplicationComponent
  BUTTON_CLASSES = {
    normal: <<~TEXT.split.join(" "),
            bg-red-500
            hover:shadow-xl
            shadow-red-200
            cursor-pointer
            font-semibold
            px-8
            py-4
            text-white
            rounded-full
            flex
            items-center
            gap-3
            TEXT
    big: ""
  }

  option :cart_itemable
  option :variant, optional: true, default: proc { :normal }
  validates :variant, inclusion: { in: [ :normal, :big ] }

  def button_class
    BUTTON_CLASSES[variant]
  end

  def turbo_params
    {
        cart_itemable_type: helpers.k(cart_itemable).cart_itemable_type,
        cart_itemable_id: helpers.k(cart_itemable).cart_itemable_id
    }
  end
end
