require "open-uri"
require "net/http"
require "json"
require "uri"

def random_price = rand(23..72)
def random_weight = rand(10..100)

def download_json_as_hash(url)
  scheme = url.split(":").first
  uri = URI(url)
  request = Net::HTTP::Get.new(uri)
  request["Accept-Language"] = "en-us"
  response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == scheme) do |http|
    http.request(request)
  end

  JSON.parse(response.body)
end

def assign_remote_image_for_attachment(record, field_name, image_url)
  record.send(field_name).attach(
    io: URI.open(URI::DEFAULT_PARSER.escape("https://media-v3.dominos.ua#{image_url}")),
    filename: image_url.split("/").last,
    content_type: "image/#{image_url.split(".").last}"
  )
end

def pre_generate_pizza_variants(pizza)
  pizza_ingredients = pizza.pizza_ingredients.all.map { |pi| { pizza_top_id: pi.pizza_top_id, quantity: pi.quantity } }
    .sort_by { |i| i[:pizza_top_id] }

  PizzaSize.all.each do |ps|
    PizzaDough.all.each do |pd|
      PizzaCrust.all.to_a.prepend(nil).each do |pc|
        pizza_create_params = {
          pizza_id: pizza.id,
          pizza_size_id: ps.id,
          pizza_dough_id: pd.id,
          pizza_crust_id: pc&.id || nil,
          custom_pizza_ingredients_attributes: pizza_ingredients
        }

        pizza_variant = PizzaVariant.find_or_initialize_by(fingerprint: PizzaVariant.hash_request_params(pizza_create_params))

        next unless pizza_variant.new_record?

        pizza_variant.pizza_id = pizza.id
        pizza_variant.pizza_size_id = ps.id
        pizza_variant.pizza_dough_id = pd.id
        pizza_variant.pizza_crust_id = pc&.id || nil

        pizza_ingredients.each do |pi|
          pizza_variant.pizza_variant_ingredients.build(pizza_top_id: pi[:pizza_top_id], quantity: pi[:quantity])
        end

        pizza_variant.save!
      end
    end
  end
end

dominos_toppings_categories = download_json_as_hash("https://api-v3.dominos.ua/api/v3/product-topping-groups?region=6")
dominos_toppings_categories.each do |d_topping_cat|
  PizzaTopCategory.find_or_create_by(name: d_topping_cat["name"])
end

dominos_pizza_top_id_to_pizza_name_mapping = { 24 => "Meat", 23 => "Cheese", 21 => "Sauces", 22 => "Vegetables" }

dominos_data = download_json_as_hash("https://api-v3.dominos.ua/api/v3/product-cards?region=6")
dominos_pizzas = dominos_data.filter { |item| item["productCategoryCode"] == "Pizza" }

dominos_pizzas.each do |dominos_pizza|
  # size
  dominos_pizza["sizes"].each do |dominos_pizza_size|
    PizzaSize.find_or_create_by!(name: dominos_pizza_size["name"])
  end

  # dough
  dominos_pizza["flavors"].filter { |flavor| !flavor["isBort"] }.each do |dominos_pizza_dough|
    PizzaDough.find_or_create_by!(name: dominos_pizza_dough["name"])
  end

  # crust
  dominos_pizza["flavors"].filter { |flavor| flavor["isBort"] }.each do |dominos_pizza_crust|
    PizzaCrust.find_or_create_by!(name: dominos_pizza_crust["name"])
  end

  pizza = Pizza.find_or_initialize_by(slug: dominos_pizza["slug"])
  if pizza.new_record?
    pizza.name = dominos_pizza["name"]

    assign_remote_image_for_attachment(pizza, "image", dominos_pizza["image"])
    assign_remote_image_for_attachment(pizza, "constructor_image", dominos_pizza["imageDetailed"])

    pizza.pizza_size = PizzaSize.first
    pizza.pizza_dough = PizzaDough.first
    pizza.save!
    puts "Created pizza: #{pizza.name}"
  end

  dominos_pizza["toppings"].each do |dominos_top|
    pizza_top = PizzaTop.find_or_create_by!(
      name: dominos_top["name"],
      price: 6,
      pizza_top_category: PizzaTopCategory.find_by(name: dominos_pizza_top_id_to_pizza_name_mapping[dominos_top["toppingGroupId"]])
    )
    assign_remote_image_for_attachment(pizza_top, "image", dominos_top["image"]) unless pizza_top.image.attached?
    pizza_ingredient = PizzaIngredient.find_or_initialize_by(pizza: pizza, pizza_top: pizza_top)
    if pizza_ingredient.new_record?
      pizza_ingredient.quantity = dominos_top["quantity"]
      pizza_ingredient.save!
    end
  end
end

Pizza.all.each do |p|
  pre_generate_pizza_variants(p)
  puts "Pre-genrated variants for: #{p.name}"
end

PizzaSize.all.each_with_index do |pizza_size, pizza_size_index|
  pizza_size_name = pizza_size.name
  pizza_size = PizzaSize.find_by! name: pizza_size_name

  PizzaCrust.all.each do |pizza_crust|
    pizza_crust_name = pizza_crust.name
    pizza_crust = PizzaCrust.find_by! name: pizza_crust_name
    pizza_crust_info = pizza_crust.pizza_crust_infos.find_or_initialize_by(pizza_size: pizza_size) do |record|
      record.weight = random_weight
      record.price = random_price
    end
    pizza_crust_info.save!
  end

  PizzaDough.all.each do |pizza_dough|
    pizza_dough_name = pizza_dough.name
    pizza_dough = PizzaDough.find_by! name: pizza_dough_name
    pizza_dough_info = pizza_dough.pizza_dough_infos.find_or_initialize_by(pizza_size: pizza_size) do |record|
      record.weight = random_weight
      record.price = random_price
    end
    pizza_dough_info.save!
  end
end

dominos_drinks = dominos_data.filter { |item| item["productCategoryCode"] == "Drinks" }

dominos_drinks.each do |dominos_drink|
  drink = Drink.find_or_initialize_by(slug: dominos_drink["slug"])
  if drink.new_record?
    drink.name = dominos_drink["name"]

    assign_remote_image_for_attachment(drink, "image", dominos_drink["image"])
    assign_remote_image_for_attachment(drink, "detail_image", dominos_drink["imageDetailed"])

    dominos_drink["sizes"].each do |dominos_drink_size|
      drink.drink_variants.build(name: dominos_drink_size["name"], price: random_price)
    end

    drink.save!
    puts "Created drink: #{drink.name}"
  end
end
