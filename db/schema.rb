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

ActiveRecord::Schema[7.1].define(version: 2024_05_06_094414) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.index ["created_at"], name: "index_categories_on_created_at"
    t.index ["id"], name: "index_categories_on_id"
    t.index ["name"], name: "index_categories_on_name"
    t.index ["uid"], name: "index_categories_on_uid", unique: true
    t.index ["updated_at"], name: "index_categories_on_updated_at"
  end

  create_table "customers", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_uid"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.index ["created_at"], name: "index_customers_on_created_at"
    t.index ["email"], name: "index_customers_on_email"
    t.index ["id"], name: "index_customers_on_id"
    t.index ["name"], name: "index_customers_on_name"
    t.index ["phone"], name: "index_customers_on_phone"
    t.index ["uid"], name: "index_customers_on_uid", unique: true
    t.index ["updated_at"], name: "index_customers_on_updated_at"
  end

  create_table "order_details", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_uid"
    t.string "product_uid"
    t.float "price"
    t.integer "qty"
    t.float "discount_value"
    t.text "notes"
    t.index ["created_at"], name: "index_order_details_on_created_at"
    t.index ["id"], name: "index_order_details_on_id"
    t.index ["order_uid"], name: "index_order_details_on_order_uid"
    t.index ["product_uid"], name: "index_order_details_on_product_uid"
    t.index ["uid"], name: "index_order_details_on_uid", unique: true
    t.index ["updated_at"], name: "index_order_details_on_updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_uid"
    t.float "sub_total"
    t.float "discount_total"
    t.float "tax"
    t.float "grand_total"
    t.text "notes"
    t.string "status"
    t.string "payment_status"
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["customer_uid"], name: "index_orders_on_customer_uid"
    t.index ["id"], name: "index_orders_on_id"
    t.index ["payment_status"], name: "index_orders_on_payment_status"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["uid"], name: "index_orders_on_uid", unique: true
    t.index ["updated_at"], name: "index_orders_on_updated_at"
  end

  create_table "payment_channels", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.text "notes"
    t.string "payment_flow"
    t.string "status"
    t.string "vendor"
    t.string "icon_path"
    t.string "icon_file_name"
    t.index ["created_at"], name: "index_payment_channels_on_created_at"
    t.index ["icon_file_name"], name: "index_payment_channels_on_icon_file_name"
    t.index ["icon_path"], name: "index_payment_channels_on_icon_path"
    t.index ["id"], name: "index_payment_channels_on_id"
    t.index ["name"], name: "index_payment_channels_on_name"
    t.index ["status"], name: "index_payment_channels_on_status"
    t.index ["uid"], name: "index_payment_channels_on_uid", unique: true
    t.index ["updated_at"], name: "index_payment_channels_on_updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_uid"
    t.float "amount"
    t.datetime "paid_at", precision: nil
    t.string "status"
    t.string "ref_id"
    t.string "partner_ref_id"
    t.string "payment_channel_uid"
    t.string "payment_code"
    t.string "payment_name"
    t.text "notes"
    t.index ["created_at"], name: "index_payments_on_created_at"
    t.index ["id"], name: "index_payments_on_id"
    t.index ["order_uid"], name: "index_payments_on_order_uid"
    t.index ["paid_at"], name: "index_payments_on_paid_at"
    t.index ["partner_ref_id"], name: "index_payments_on_partner_ref_id"
    t.index ["payment_channel_uid"], name: "index_payments_on_payment_channel_uid"
    t.index ["payment_code"], name: "index_payments_on_payment_code"
    t.index ["ref_id"], name: "index_payments_on_ref_id"
    t.index ["status"], name: "index_payments_on_status"
    t.index ["uid"], name: "index_payments_on_uid", unique: true
    t.index ["updated_at"], name: "index_payments_on_updated_at"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_uid"
    t.string "storage"
    t.string "path"
    t.string "file_name"
    t.index ["created_at"], name: "index_product_images_on_created_at"
    t.index ["file_name"], name: "index_product_images_on_file_name"
    t.index ["id"], name: "index_product_images_on_id"
    t.index ["path"], name: "index_product_images_on_path"
    t.index ["product_uid"], name: "index_product_images_on_product_uid"
    t.index ["storage"], name: "index_product_images_on_storage"
    t.index ["uid"], name: "index_product_images_on_uid", unique: true
    t.index ["updated_at"], name: "index_product_images_on_updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category_uid"
    t.string "name"
    t.text "description"
    t.float "price", default: 0.0
    t.integer "stock", default: 0
    t.index ["category_uid"], name: "index_products_on_category_uid"
    t.index ["created_at"], name: "index_products_on_created_at"
    t.index ["id"], name: "index_products_on_id"
    t.index ["name"], name: "index_products_on_name"
    t.index ["uid"], name: "index_products_on_uid", unique: true
    t.index ["updated_at"], name: "index_products_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "user_type"
    t.string "status"
    t.string "password_digest"
    t.index ["created_at"], name: "index_users_on_created_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["id"], name: "index_users_on_id"
    t.index ["name"], name: "index_users_on_name"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["status"], name: "index_users_on_status"
    t.index ["uid"], name: "index_users_on_uid", unique: true
    t.index ["updated_at"], name: "index_users_on_updated_at"
    t.index ["user_type"], name: "index_users_on_user_type"
  end

end
