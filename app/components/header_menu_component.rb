# frozen_string_literal: true

class HeaderMenuComponent < ApplicationComponent
  option :current_path

  def menu_item_schema
    @menu_item_schema ||= Struct.new("MenuItemSchema", :title, :path)
  end

  def menu_items
    [
      menu_item_schema.new(title: "Pizzas", path: "/"),
      menu_item_schema.new(title: "Drinks", path: "/drinks")
    ]
  end

  def classes(menu_item)
    menu_item.path == current_path ? "text-white underline" : "text-white"
  end
end
