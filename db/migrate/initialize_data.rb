
class InitializeData < ActiveRecord::Migration[5.2]
def change 
    create_table "channels", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "genres", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "listings", force: :cascade do |t|
      t.integer "watchlist_id"
      t.integer "show_id"
      t.integer "user_id"
      t.string "user_status"
      t.integer "user_season"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "fav", default: false
    end
  
    create_table "show_genres", force: :cascade do |t|
      t.integer "show_id"
      t.integer "genre_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "shows", force: :cascade do |t|
      t.string "title"
      t.text "description"
      t.integer "channel_id"
      t.string "day"
      t.string "time"
      t.integer "current_season"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "created_by"
    end
  
    create_table "users", force: :cascade do |t|
      t.string "email"
      t.string "password_digest"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "username"
    end
  
    create_table "watchlists", force: :cascade do |t|
      t.string "name"
      t.text "description"
      t.integer "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
  end
end