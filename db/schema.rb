# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_06_12_033122) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cart_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.string "cart_itemable_type", null: false
    t.bigint "cart_itemable_id", null: false
    t.integer "quantity", default: 1, null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["cart_itemable_type", "cart_itemable_id"], name: "index_cart_items_on_cart_itemable"
  end

  create_table "carts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drink_variants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "drink_id", null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_drink_variants_on_drink_id"
  end

  create_table "drinks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_drinks_on_name", unique: true
    t.index ["slug"], name: "index_drinks_on_slug", unique: true
  end

  create_table "pizza_crust_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_size_id", null: false
    t.bigint "pizza_crust_id", null: false
    t.integer "weight", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_crust_id"], name: "index_pizza_crust_infos_on_pizza_crust_id"
    t.index ["pizza_size_id", "pizza_crust_id"], name: "index_pizza_crust_infos_on_pizza_size_id_and_pizza_crust_id", unique: true
    t.index ["pizza_size_id"], name: "index_pizza_crust_infos_on_pizza_size_id"
  end

  create_table "pizza_crusts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizza_crusts_on_name", unique: true
  end

  create_table "pizza_custom_ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_custom_id"
    t.bigint "pizza_top_id"
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_custom_id", "pizza_top_id"], name: "idx_on_pizza_custom_id_pizza_top_id_0a303b01ea", unique: true
    t.index ["pizza_custom_id"], name: "index_pizza_custom_ingredients_on_pizza_custom_id"
    t.index ["pizza_top_id"], name: "index_pizza_custom_ingredients_on_pizza_top_id"
  end

  create_table "pizza_customs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_id"
    t.bigint "pizza_size_id"
    t.bigint "pizza_dough_id"
    t.bigint "pizza_crust_id"
    t.string "fingerprint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fingerprint"], name: "index_pizza_customs_on_fingerprint", unique: true
    t.index ["pizza_crust_id"], name: "index_pizza_customs_on_pizza_crust_id"
    t.index ["pizza_dough_id"], name: "index_pizza_customs_on_pizza_dough_id"
    t.index ["pizza_id"], name: "index_pizza_customs_on_pizza_id"
    t.index ["pizza_size_id"], name: "index_pizza_customs_on_pizza_size_id"
  end

  create_table "pizza_dough_infos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_size_id", null: false
    t.bigint "pizza_dough_id", null: false
    t.integer "weight", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_dough_id"], name: "index_pizza_dough_infos_on_pizza_dough_id"
    t.index ["pizza_size_id", "pizza_dough_id"], name: "index_pizza_dough_infos_on_pizza_size_id_and_pizza_dough_id", unique: true
    t.index ["pizza_size_id"], name: "index_pizza_dough_infos_on_pizza_size_id"
  end

  create_table "pizza_doughs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizza_doughs_on_name", unique: true
  end

  create_table "pizza_ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_id", null: false
    t.bigint "pizza_top_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_id", "pizza_top_id"], name: "index_pizza_ingredients_on_pizza_id_and_pizza_top_id", unique: true
    t.index ["pizza_id"], name: "index_pizza_ingredients_on_pizza_id"
    t.index ["pizza_top_id"], name: "index_pizza_ingredients_on_pizza_top_id"
  end

  create_table "pizza_sizes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizza_sizes_on_name", unique: true
  end

  create_table "pizza_top_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizza_top_categories_on_name", unique: true
  end

  create_table "pizza_tops", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_top_category_id", null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizza_tops_on_name", unique: true
    t.index ["pizza_top_category_id"], name: "index_pizza_tops_on_pizza_top_category_id"
  end

  create_table "pizza_variant_ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_variant_id", null: false
    t.bigint "pizza_top_id", null: false
    t.integer "quantity", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_top_id"], name: "index_pizza_variant_ingredients_on_pizza_top_id"
    t.index ["pizza_variant_id", "pizza_top_id"], name: "idx_on_pizza_variant_id_pizza_top_id_eed16d00f6", unique: true
    t.index ["pizza_variant_id"], name: "index_pizza_variant_ingredients_on_pizza_variant_id"
  end

  create_table "pizza_variants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "pizza_id"
    t.bigint "pizza_size_id"
    t.bigint "pizza_dough_id"
    t.bigint "pizza_crust_id"
    t.string "fingerprint", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fingerprint"], name: "index_pizza_variants_on_fingerprint", unique: true
    t.index ["pizza_crust_id"], name: "index_pizza_variants_on_pizza_crust_id"
    t.index ["pizza_dough_id"], name: "index_pizza_variants_on_pizza_dough_id"
    t.index ["pizza_id"], name: "index_pizza_variants_on_pizza_id"
    t.index ["pizza_size_id"], name: "index_pizza_variants_on_pizza_size_id"
  end

  create_table "pizzas", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "pizza_size_id", null: false
    t.bigint "pizza_dough_id", null: false
    t.bigint "pizza_crust_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pizzas_on_name", unique: true
    t.index ["pizza_crust_id"], name: "index_pizzas_on_pizza_crust_id"
    t.index ["pizza_dough_id"], name: "index_pizzas_on_pizza_dough_id"
    t.index ["pizza_size_id"], name: "index_pizzas_on_pizza_size_id"
    t.index ["slug"], name: "index_pizzas_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "drink_variants", "drinks"
  add_foreign_key "pizza_crust_infos", "pizza_crusts"
  add_foreign_key "pizza_crust_infos", "pizza_sizes"
  add_foreign_key "pizza_custom_ingredients", "pizza_customs"
  add_foreign_key "pizza_custom_ingredients", "pizza_tops"
  add_foreign_key "pizza_customs", "pizza_crusts"
  add_foreign_key "pizza_customs", "pizza_doughs"
  add_foreign_key "pizza_customs", "pizza_sizes"
  add_foreign_key "pizza_customs", "pizzas"
  add_foreign_key "pizza_dough_infos", "pizza_doughs"
  add_foreign_key "pizza_dough_infos", "pizza_sizes"
  add_foreign_key "pizza_ingredients", "pizza_tops"
  add_foreign_key "pizza_ingredients", "pizzas"
  add_foreign_key "pizza_tops", "pizza_top_categories"
  add_foreign_key "pizza_variant_ingredients", "pizza_tops"
  add_foreign_key "pizza_variant_ingredients", "pizza_variants"
  add_foreign_key "pizza_variants", "pizza_crusts"
  add_foreign_key "pizza_variants", "pizza_doughs"
  add_foreign_key "pizza_variants", "pizza_sizes"
  add_foreign_key "pizza_variants", "pizzas"
  add_foreign_key "pizzas", "pizza_crusts"
  add_foreign_key "pizzas", "pizza_doughs"
  add_foreign_key "pizzas", "pizza_sizes"
end
