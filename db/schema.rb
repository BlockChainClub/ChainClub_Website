# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171231024623) do

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.integer "topic_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "article_comments", force: :cascade do |t|
    t.text "content"
    t.integer "official_article_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "commentable_id"
    t.string "commentable_type"
    t.string "title"
    t.text "body"
    t.string "subject"
    t.integer "user_id", null: false
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "city"
    t.string "publisher"
    t.text "benefit"
    t.text "introduce"
    t.text "demand"
    t.date "deadline"
    t.text "process"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "meetup_groups", force: :cascade do |t|
    t.string "title"
    t.string "meetup_type"
    t.string "time_limit"
    t.string "activity_time"
    t.string "city"
    t.string "address"
    t.string "register"
    t.text "introduce"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "official_articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "author"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "article_category_id"
    t.string "status", default: "draft"
    t.index ["article_category_id"], name: "index_official_articles_on_article_category_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "group_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.date "birthday"
    t.string "location"
    t.string "school"
    t.string "education"
    t.string "company"
    t.string "occupation"
    t.string "position"
    t.string "address"
    t.string "weibo"
    t.string "wechat"
    t.string "github"
    t.integer "qq"
    t.text "bio"
    t.text "specialty"
    t.text "introduce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "site_nodes", force: :cascade do |t|
    t.string "name"
    t.integer "sort", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sort"], name: "index_site_nodes_on_sort"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "description"
    t.integer "site_node_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_node_id"], name: "index_sites_on_site_node_id"
    t.index ["url"], name: "index_sites_on_url"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "time_zone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
