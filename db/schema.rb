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

ActiveRecord::Schema[7.0].define(version: 2023_07_20_121232) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_activities_on_hotel_id"
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_amenities_on_hotel_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.bigint "room_id", null: false
    t.date "date"
    t.decimal "price"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_calendars_on_room_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "description"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "content"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_messages_on_hotel_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reservation_id", null: false
    t.decimal "amount"
    t.date "payment_date"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_payments_on_reservation_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.float "average_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_ratings_on_hotel_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "number_of_guests"
    t.decimal "total_price"
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_reviews_on_hotel_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "room_type"
    t.integer "number_of_beds"
    t.decimal "price_per_night"
    t.text "description"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "hotels"
  add_foreign_key "amenities", "hotels"
  add_foreign_key "calendars", "rooms"
  add_foreign_key "messages", "hotels"
  add_foreign_key "payments", "reservations"
  add_foreign_key "payments", "users"
  add_foreign_key "ratings", "hotels"
  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "hotels"
  add_foreign_key "reviews", "users"
  add_foreign_key "rooms", "hotels"
end
