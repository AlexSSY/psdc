Rails.application.routes.draw do
  mount RailsIcons::Engine, at: "/rails_icons"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pizzas#index"
  get "/drinks", controller: :drinks, action: :index, as: "drinks"
  resource :pizza_variant, only: [ :create ]
  resource :cart_item, only: [ :create, :destroy ]
  get "/pizza_variants/variant_partial/:id", controller: :pizza_variants, action: :variant_partial, as: "pizza_variants_variant_partial"
  delete "/cart_items/destroy_all", controller: :cart_items, action: :destroy_all, as: "cart_items_destroy_all"
  delete "/cart", controller: :carts, action: :clear, as: "clear_cart"
  get "/cart", controller: :carts, action: :show, as: "show_cart"
  scope "pizza" do
    get "constructor/new", controller: :pizza_customs, action: :new, as: "new_pizza_custom"
    post "constructor", controller: :pizza_customs, action: :create, as: "pizza_custom"
  end
end
