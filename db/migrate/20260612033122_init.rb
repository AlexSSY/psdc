class Init < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_top_categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :pizza_top_categories, :name, unique: true

    create_table :pizza_tops do |t|
      t.references :pizza_top_category, foreign_key: true, null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :pizza_tops, :name, unique: true

    create_table :pizza_doughs do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :pizza_doughs, :name, unique: true

    create_table :pizza_sizes do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :pizza_sizes, :name, unique: true

    create_table :pizza_crusts do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :pizza_crusts, :name, unique: true

    create_table :pizzas do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :pizza_size, foreign_key: true, null: false
      t.references :pizza_dough, foreign_key: true, null: false
      t.references :pizza_crust, foreign_key: true

      t.timestamps
    end

    add_index :pizzas, :name, unique: true
    add_index :pizzas, :slug, unique: true

    create_table :pizza_crust_infos do |t|
      t.references :pizza_size, foreign_key: true, null: false
      t.references :pizza_crust, foreign_key: true, null: false
      t.integer :weight, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :pizza_crust_infos, [ :pizza_size_id, :pizza_crust_id ], unique: true

    create_table :pizza_dough_infos do |t|
      t.references :pizza_size, foreign_key: true, null: false
      t.references :pizza_dough, foreign_key: true, null: false
      t.integer :weight, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :pizza_dough_infos, [ :pizza_size_id, :pizza_dough_id ], unique: true

    create_table :pizza_ingredients do |t|
      t.references :pizza, foreign_key: true, null: false
      t.references :pizza_top, foreign_key: true, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end

    add_index :pizza_ingredients, [ :pizza_id, :pizza_top_id ], unique: true

    create_table :pizza_variants do |t|
      t.references :pizza, foreign_key: true, null: true
      t.references :pizza_size, foreign_key: true, null: true
      t.references :pizza_dough, foreign_key: true, null: true
      t.references :pizza_crust, foreign_key: true, null: true
      t.string :fingerprint, null: false

      t.timestamps
    end

    add_index :pizza_variants, :fingerprint, unique: true

    create_table :pizza_variant_ingredients do |t|
      t.references :pizza_variant, foreign_key: true, null: false
      t.references :pizza_top, foreign_key: true, null: false
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end

    add_index :pizza_variant_ingredients, [ :pizza_variant_id, :pizza_top_id ], unique: true

    create_table :carts do |t|
      t.timestamps
    end

    create_table :cart_items do |t|
      t.references :cart, foreign_key: true, null: false
      t.references :cart_itemable, polymorphic: true, null: false
      t.integer :quantity, default: 1, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.timestamps
    end

    create_table :drinks do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index :drinks, :slug, unique: true
    add_index :drinks, :name, unique: true

    create_table :drink_variants do |t|
      t.references :drink, foreign_key: true, null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.timestamps
    end

    create_table :pizza_customs do |t|
      t.references :pizza, foreign_key: true, null: true
      t.references :pizza_size, foreign_key: true, null: true
      t.references :pizza_dough, foreign_key: true, null: true
      t.references :pizza_crust, foreign_key: true, null: true
      t.string :fingerprint
      t.timestamps
    end

    add_index :pizza_customs, :fingerprint, unique: true

    create_table :pizza_custom_ingredients do |t|
      t.references :pizza_custom, foreign_key: true
      t.references :pizza_top, foreign_key: true
      t.integer :quantity, null: false, default: 0
      t.timestamps
    end

    add_index :pizza_custom_ingredients, [ :pizza_custom_id, :pizza_top_id ], unique: true
  end
end
