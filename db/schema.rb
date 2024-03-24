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

ActiveRecord::Schema[7.1].define(version: 2024_03_24_141848) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
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

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "plant_categories", force: :cascade do |t|
    t.string "plant_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plant_subcategories", force: :cascade do |t|
    t.string "plant_subcategory"
    t.integer "plant_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_category_id"], name: "index_plant_subcategories_on_plant_category_id"
  end

  create_table "plant_sunlight_amounts", force: :cascade do |t|
    t.integer "plant_id", null: false
    t.integer "sunlight_amount_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_plant_sunlight_amounts_on_plant_id"
    t.index ["sunlight_amount_id"], name: "index_plant_sunlight_amounts_on_sunlight_amount_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "scraper_id"
    t.string "name"
    t.string "sku"
    t.string "latin_name"
    t.string "family_name"
    t.integer "maturity_min"
    t.integer "maturity_max"
    t.integer "zone_min"
    t.integer "zone_max"
    t.text "description"
    t.boolean "drought_tolerant"
    t.boolean "salt_tolerant"
    t.boolean "poisonous"
    t.boolean "pet_friendly"
    t.boolean "medicinal"
    t.boolean "edible"
    t.boolean "fruits"
    t.boolean "thorns"
    t.string "growth"
    t.string "care_level"
    t.string "image_link"
    t.string "info_link"
    t.integer "plant_subcategory_id", null: false
    t.integer "seed_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_subcategory_id"], name: "index_plants_on_plant_subcategory_id"
    t.index ["seed_type_id"], name: "index_plants_on_seed_type_id"
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "price"
    t.string "weight"
    t.integer "quantity"
    t.integer "plant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plant_id"], name: "index_prices_on_plant_id"
  end

  create_table "seed_types", force: :cascade do |t|
    t.string "seed_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sunlight_amounts", force: :cascade do |t|
    t.string "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "plant_subcategories", "plant_categories"
  add_foreign_key "plant_sunlight_amounts", "plants"
  add_foreign_key "plant_sunlight_amounts", "sunlight_amounts"
  add_foreign_key "plants", "plant_subcategories"
  add_foreign_key "plants", "seed_types"
  add_foreign_key "prices", "plants"
end
