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

ActiveRecord::Schema.define(version: 20171006093910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "dblink"
  enable_extension "hstore"
  enable_extension "intarray"
  enable_extension "postgis_topology"
  enable_extension "uuid-ossp"

  create_table "account_plan_histories", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.integer "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "plan_id"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "trial_started_at"
    t.datetime "billed_at"
    t.string "state", limit: 255, default: "active"
    t.datetime "state_changed_at"
    t.datetime "paid_to"
    t.string "type", limit: 255, default: "Account"
    t.boolean "hide_preorder_products", default: false
    t.integer "marginality"
    t.index ["plan_id"], name: "index_accounts_on_plan_id"
    t.index ["trial_started_at", "billed_at"], name: "index_accounts_on_trial_started_at_and_billed_at"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "kind", limit: 255
    t.hstore "fields"
    t.integer "activitiable_id"
    t.string "activitiable_type", limit: 255
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["activitiable_id", "activitiable_type"], name: "index_activities_on_activitiable_id_and_activitiable_type"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "addresses", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.hstore "info"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.string "phone", limit: 255
    t.text "address"
    t.string "city_id", limit: 255
    t.string "zip_code", limit: 255
  end

  create_table "badges", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "photo", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "badge_id"
    t.index ["badge_id", "user_id"], name: "index_badges_users_on_badge_id_and_user_id", unique: true
    t.index ["badge_id"], name: "index_badges_users_on_badge_id"
    t.index ["user_id"], name: "index_badges_users_on_user_id"
  end

  create_table "banner_places", id: :serial, force: :cascade do |t|
    t.boolean "enabled", default: false
    t.text "code"
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "label", limit: 255, default: ""
    t.integer "width", default: 100
    t.integer "height", default: 100
  end

  create_table "banners", id: :serial, force: :cascade do |t|
    t.string "link", limit: 255
    t.integer "position"
    t.string "file", limit: 255
    t.boolean "published", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "mobile_file", limit: 255
    t.string "kind", limit: 255
    t.string "app_link", limit: 255, default: "", null: false
    t.index ["position"], name: "index_banners_on_position"
  end

  create_table "brands", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "slug", limit: 255
    t.string "synonyms", limit: 255, default: [], array: true
    t.boolean "published", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "country_id"
    t.integer "delivery_area_id"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.string "eng_title", limit: 255
    t.string "slug", limit: 255
    t.string "region_code", limit: 255
    t.string "ip", limit: 255
    t.hstore "geometry"
    t.integer "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.geography "geo", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.integer "users_count", default: 0
    t.integer "priority"
    t.boolean "active_subdomain", default: false, null: false
    t.string "subdomain", limit: 255
    t.integer "delivery_price", default: 0, null: false
    t.string "contact_phone", limit: 255
    t.string "delivery_addresses", limit: 255, default: [], array: true
    t.index ["country_id"], name: "index_cities_on_country_id"
    t.index ["geo"], name: "index_cities_on_geo", using: :gist
    t.index ["name"], name: "index_cities_on_name"
  end

  create_table "collections", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "collectibles_count", default: 0, null: false
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "portfolio"
    t.string "type", limit: 255, default: "Collection"
    t.boolean "hidden", default: false
    t.index ["created_at"], name: "index_collections_on_created_at"
    t.index ["user_id"], name: "user_id_on_collections"
  end

  create_table "collectors", id: :serial, force: :cascade do |t|
    t.integer "collection_id"
    t.string "collectible_type", limit: 255
    t.integer "collectible_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "cover", default: false
    t.integer "main_tag_id"
    t.text "description"
    t.integer "view_counter", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.boolean "synched", default: false, null: false
    t.index ["collectible_type", "collectible_id"], name: "index_collectors_on_collectible_type_and_collectible_id"
    t.index ["collection_id"], name: "index_collectors_on_collection_id"
  end

  create_table "colors", id: :serial, force: :cascade do |t|
    t.integer "colorable_id"
    t.string "colorable_type", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "search_color_id"
    t.decimal "search_factor", precision: 8, scale: 2
    t.integer "distance", default: 0
    t.boolean "active", default: true
    t.index ["colorable_id", "colorable_type"], name: "by_colorable"
    t.index ["colorable_id"], name: "colors_aggregate_colorable_id"
    t.index ["colorable_type"], name: "index_colors_on_colorable_type"
    t.index ["distance"], name: "index_colors_on_distance"
    t.index ["search_color_id", "search_factor", "colorable_type"], name: "colors_similar"
    t.index ["search_color_id"], name: "index_colors_on_search_color_id"
    t.index ["search_factor"], name: "index_colors_on_search_factor"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "commentable_id"
    t.string "commentable_type", limit: 255
    t.string "anchor", limit: 255
    t.string "title", limit: 255
    t.text "raw_content"
    t.text "content"
    t.string "state", limit: 255
    t.boolean "spam", default: false
    t.integer "parent_id"
    t.integer "depth", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "likes_count", default: 0, null: false
    t.hstore "legacy_info"
    t.boolean "hide"
    t.index ["commentable_id", "commentable_type"], name: "comments_commentable"
    t.index ["user_id"], name: "comments_user_id"
  end

  create_table "commerce_categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "fixed_url", limit: 255
    t.text "description"
    t.integer "tag_id"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "main_tag_id"
    t.string "slug", limit: 255
    t.integer "position", default: 0, null: false
    t.string "full_path", limit: 255
    t.string "thumbnail", limit: 255
    t.string "cover", limit: 255
    t.boolean "virtual", default: false
    t.string "virtual_url", limit: 10000
    t.index ["lft"], name: "index_commerce_categories_on_lft"
    t.index ["main_tag_id"], name: "index_commerce_categories_on_main_tag_id"
    t.index ["rgt"], name: "index_commerce_categories_on_rgt"
    t.index ["tag_id"], name: "index_commerce_categories_on_tag_id"
  end

  create_table "commerce_categories_product_categories", id: false, force: :cascade do |t|
    t.integer "commerce_category_id"
    t.integer "product_category_id"
  end

  create_table "commerce_category_groups", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "slug", limit: 255
    t.index ["slug"], name: "index_commerce_category_groups_on_slug"
  end

  create_table "commerce_category_to_groups", id: :serial, force: :cascade do |t|
    t.integer "commerce_category_id"
    t.integer "commerce_category_group_id"
    t.integer "position", default: 0, null: false
  end

  create_table "common_pages", id: :serial, force: :cascade do |t|
    t.string "query", limit: 500
    t.string "state", limit: 255
    t.string "meta_title", limit: 255
    t.text "meta_description"
    t.string "meta_keywords", limit: 255
    t.string "title", limit: 255
    t.text "description"
    t.string "fixed_url", limit: 255
    t.string "type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["fixed_url"], name: "index_common_pages_on_fixed_url"
    t.index ["query"], name: "index_common_pages_on_query"
    t.index ["state"], name: "index_common_pages_on_state"
  end

  create_table "company_types", id: :serial, force: :cascade do |t|
    t.text "name", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255, default: "", null: false
    t.integer "tag_id"
    t.string "plural", limit: 255
    t.integer "position"
  end

  create_table "counterparties", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255
    t.string "name", limit: 255
    t.index ["slug"], name: "index_counterparties_on_slug", unique: true
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "country_code", limit: 255
    t.string "eng_title", limit: 255
    t.string "slug", limit: 255
    t.integer "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_countries_on_name"
  end

  create_table "credentials", id: :serial, force: :cascade do |t|
    t.string "uid", limit: 255
    t.string "provider", limit: 255
    t.text "access_token"
    t.text "access_token_secret"
    t.integer "user_id"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "friends_list", limit: 255, array: true
    t.index ["user_id"], name: "index_credentials_on_user_id"
  end

  create_table "declensions", id: :serial, force: :cascade do |t|
    t.string "base", limit: 255
    t.string "roditelny", limit: 255
    t.string "datelny", limit: 255
    t.string "vinitelny", limit: 255
    t.string "tvoritelny", limit: 255
    t.string "predlojny", limit: 255
    t.boolean "plural", default: false
    t.string "base_opposite", limit: 255
    t.index ["base"], name: "index_declensions_on_base"
  end

  create_table "delivery_areas", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.integer "country_id"
    t.integer "tag_id"
    t.string "slug", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "index_delivery_areas_on_country_id"
    t.index ["tag_id"], name: "index_delivery_areas_on_tag_id"
  end

  create_table "delivery_areas_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "delivery_area_id"
    t.index ["delivery_area_id"], name: "delivery_areas_users_delivery_area_id_idx"
    t.index ["user_id", "delivery_area_id"], name: "user_id_delivery_areas_id"
    t.index ["user_id"], name: "delivery_areas_user_id"
  end

  create_table "designers", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "middle_name", limit: 255
    t.string "phone", limit: 255
    t.string "email", limit: 255
    t.string "site", limit: 255
    t.string "document", limit: 255
    t.string "profession", limit: 255
    t.date "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["phone"], name: "index_designers_on_phone", unique: true
  end

  create_table "fast_links", id: :serial, force: :cascade do |t|
    t.text "url"
    t.text "description"
    t.integer "commerce_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json "url_params", default: {}, null: false
    t.integer "products_count", default: 0
    t.boolean "enabled", default: true, null: false
  end

  create_table "favorite_collections", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_favorite_collections_on_user_id"
  end

  create_table "favorite_items", id: :serial, force: :cascade do |t|
    t.integer "favorable_id"
    t.string "favorable_type", limit: 255
    t.integer "favorite_collection_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["favorable_id", "favorable_type"], name: "index_favorite_items_on_favorable_id_and_favorable_type"
    t.index ["favorite_collection_id"], name: "index_favorite_items_on_favorite_collection_id"
    t.index ["user_id", "favorable_id", "favorable_type"], name: "favorite_items_user_id_and_favorable_id_and_favorable_type_idx", unique: true
    t.index ["user_id"], name: "index_favorite_items_on_user_id"
  end

  create_table "favorite_lists", id: :serial, force: :cascade do |t|
    t.integer "product_ids", default: [], array: true
    t.integer "user_id"
  end

  create_table "feed_entries", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_subscription_id"
    t.string "event", limit: 255
    t.integer "entry_id"
    t.string "entry_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "event_at"
    t.integer "parent_id"
    t.index ["user_id", "entry_type", "entry_id"], name: "index_feed_entries_on_user_id_and_entry_type_and_entry_id", unique: true
  end

  create_table "feed_entry_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "feed_entry_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "feed_entry_desc_idx"
  end

  create_table "feed_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscribable_id"
    t.string "subscribable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id", "subscribable_type", "subscribable_id"], name: "index_feed_subscriptions_on_subscribable_and_user_id", unique: true
  end

  create_table "forums", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, default: "", null: false
    t.text "description", default: ""
    t.string "slug", limit: 255, default: ""
    t.text "meta_description", default: ""
    t.string "meta_keywords", limit: 255, default: ""
    t.string "meta_title", limit: 255, default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry", limit: 255
    t.integer "position"
    t.index ["ancestry"], name: "index_forums_on_ancestry"
  end

  create_table "imr_migration_logs", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.string "item_type", limit: 255
    t.string "state", limit: 255, default: "fail"
    t.text "last_error", default: ""
    t.integer "try_count"
    t.datetime "last_try"
    t.integer "version"
    t.index ["item_id"], name: "index_imr_migration_logs_on_item_id"
    t.index ["item_type"], name: "index_imr_migration_logs_on_item_type"
    t.index ["state"], name: "index_imr_migration_logs_on_state"
  end

  create_table "inner_photos", id: :serial, force: :cascade do |t|
    t.string "file", limit: 255
    t.integer "post_id"
    t.index ["post_id"], name: "index_inner_photos_on_post_id"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "company_id"
    t.string "document", limit: 255
    t.boolean "paid", default: false
    t.string "number", limit: 255
    t.date "billing_date"
    t.index ["company_id"], name: "index_invoices_on_company_id"
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "likes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "likeable_id"
    t.string "likeable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "logistic_operations", id: :serial, force: :cascade do |t|
    t.string "kind", limit: 255
    t.integer "price_cents"
    t.integer "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_rubrics", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "remote_id"
    t.boolean "published", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_rubrics_posts", id: :serial, force: :cascade do |t|
    t.integer "mail_rubric_id"
    t.integer "post_id"
    t.index ["mail_rubric_id"], name: "index_mail_rubrics_posts_on_mail_rubric_id"
    t.index ["post_id"], name: "index_mail_rubrics_posts_on_post_id"
  end

  create_table "metatag_templates", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.hstore "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metatag_variables", id: :serial, force: :cascade do |t|
    t.string "key", limit: 255
    t.string "value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "value_r", limit: 255
    t.index ["key"], name: "index_metatag_variables_on_key"
  end

  create_table "metatags", id: :serial, force: :cascade do |t|
    t.string "url", limit: 255
    t.text "title"
    t.text "description"
    t.string "keywords", limit: 255
    t.string "og_title", limit: 255
    t.text "og_description"
    t.text "og_image"
    t.text "og_url"
    t.string "og_type", limit: 255
    t.text "twitter_title"
    t.text "twitter_description"
    t.text "twitter_image"
    t.string "twitter_card", limit: 255
    t.text "twitter_site"
    t.text "twitter_url"
    t.text "site_description"
    t.string "h1", limit: 255
    t.text "seo_text"
    t.text "seo_text_bottom"
    t.string "image", limit: 255
    t.index ["url"], name: "index_metatags_on_url"
  end

  create_table "meter_post_stats", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.date "date"
    t.integer "teaser_views", default: 0
    t.integer "views", default: 0
    t.integer "shares", default: 0
    t.integer "saves", default: 0
    t.decimal "scr", default: "0.0"
    t.decimal "cr", default: "0.0"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "teaser_clicks"
    t.index ["post_id", "date"], name: "index_meter_post_stats_on_post_id_and_date", unique: true
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "author_id"
    t.integer "target_id"
    t.string "target_type", limit: 255
    t.integer "cause_id"
    t.string "cause_type", limit: 255
    t.string "kind", limit: 255
    t.boolean "readed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "order_id"
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", id: :serial, force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity", default: 0, null: false
    t.bigint "price_cents", default: 0, null: false
    t.string "price_currency", limit: 255, default: "RUB", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "vendor_price_cents", default: 0, null: false
    t.integer "customer_price_cents", default: 0, null: false
    t.integer "stock_id"
    t.string "product_title", limit: 255
    t.integer "company_id"
    t.string "product_sku", limit: 255
    t.integer "shipping_method_id"
    t.date "shipping_date"
    t.date "vendor_shipment_date"
    t.integer "vendor_shipment_price"
    t.date "temporary_storage_shipping_date"
    t.integer "temporary_storage_price"
    t.integer "temporary_storage_assembly_item_price"
    t.integer "customer_delivery_price"
    t.date "vendor_payment_date"
    t.string "state", limit: 255
    t.boolean "is_accepted", default: false, null: false
    t.integer "stock_quantity"
    t.string "reject_reason", limit: 255
    t.string "reject_comment", limit: 255
    t.text "comment"
    t.text "reject_reason_comment"
    t.boolean "is_upsale", default: false, null: false
    t.integer "accepted_quantity", default: 0
    t.index ["stock_id"], name: "index_order_items_on_stock_id"
  end

  create_table "order_reviews", id: :serial, force: :cascade do |t|
    t.integer "rating", null: false
    t.text "comment"
    t.string "items", limit: 255
    t.string "delivery", limit: 255
    t.string "order_again", limit: 255
    t.string "recommendation", limit: 255
    t.integer "order_id"
    t.index ["order_id"], name: "index_order_reviews_on_order_id"
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "city_id"
    t.string "state", limit: 255, null: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "phone", limit: 255
    t.string "email", limit: 255
    t.string "address", limit: 255
    t.string "zip_code", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "comment"
    t.string "source_type", limit: 255, default: "user"
    t.integer "manager_id"
    t.integer "logist_id"
    t.boolean "deleted", default: false
    t.date "delivery_date"
    t.integer "delivery_price_cents", default: 0
    t.string "device_type", limit: 255
    t.string "payment_method", limit: 255
    t.integer "delivery_method_id"
    t.integer "designer_discount", default: 0
    t.datetime "deleted_at"
    t.integer "delivery_manager_id"
    t.boolean "paid", default: false
    t.string "user_ip", limit: 255
    t.string "number", limit: 255
    t.string "type", limit: 255
    t.hstore "inherited_fields"
    t.float "marginality"
    t.datetime "state_changed_at"
    t.boolean "is_user_home_under_repair", default: false
    t.integer "designer_id"
    t.integer "promocode_discount"
    t.string "promocode_name", limit: 255
    t.integer "promocode_id"
    t.boolean "review_canceled", default: false, null: false
    t.string "registration_type", limit: 255
    t.string "special_type", limit: 255
    t.string "utm_campaign", limit: 255
    t.string "utm_medium", limit: 255
    t.string "utm_source", limit: 255
    t.string "utm_content", limit: 255
    t.string "reject_reason", limit: 255
    t.text "reject_comment"
    t.index ["delivery_method_id"], name: "index_orders_on_delivery_method_id"
    t.index ["designer_id"], name: "index_orders_on_designer_id"
    t.index ["number"], name: "index_orders_on_number"
    t.index ["promocode_id"], name: "index_orders_on_promocode_id"
    t.index ["promocode_name"], name: "index_orders_on_promocode_name"
  end

  create_table "own_companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, default: "", null: false
    t.string "inn", limit: 255, default: "", null: false
    t.string "kpp", limit: 255, default: "", null: false
    t.string "legal_address", limit: 255, default: "", null: false
    t.string "postal_address", limit: 255, default: "", null: false
    t.string "actual_address", limit: 255, default: "", null: false
    t.string "company_registration", limit: 255, default: "", null: false
    t.string "ogrn", limit: 255, default: "", null: false
    t.string "ceo", limit: 255, default: "", null: false
    t.string "bank", limit: 255, default: "", null: false
    t.string "bik", limit: 255, default: "", null: false
    t.string "correspondent_account", limit: 255, default: "", null: false
    t.string "account", limit: 255, default: "", null: false
    t.string "tax_system", limit: 255, default: "", null: false
  end

  create_table "paid_services", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "amount"
    t.integer "price"
    t.boolean "yml"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_feed_aggregations", id: false, force: :cascade do |t|
    t.integer "photo_id"
    t.integer "rating"
    t.integer "view_counter"
    t.integer "comments_count"
    t.datetime "published_at"
    t.datetime "created_at"
    t.text "tag_slugs", default: [], array: true
    t.index ["comments_count"], name: "index_photo_feed_aggregations_on_comments_count"
    t.index ["photo_id"], name: "index_photo_feed_aggregations_on_photo_id"
    t.index ["published_at", "created_at"], name: "photo_feed_aggregations_default"
    t.index ["rating"], name: "index_photo_feed_aggregations_on_rating"
    t.index ["tag_slugs"], name: "index_photo_feed_aggregations_on_tag_slugs"
    t.index ["view_counter"], name: "index_photo_feed_aggregations_on_view_counter"
  end

  create_table "photo_maps", id: :serial, force: :cascade do |t|
    t.string "digest", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "photo_id"
    t.index ["digest"], name: "index_photo_maps_on_digest", unique: true
  end

  create_table "photo_pins", id: :serial, force: :cascade do |t|
    t.integer "photo_map_id"
    t.float "x", null: false
    t.float "y", null: false
    t.string "pin_type", limit: 255, default: "text"
    t.text "link"
    t.string "text", limit: 255
    t.boolean "visible", default: true
    t.hstore "type_params"
    t.hstore "options"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["photo_map_id"], name: "index_photo_pins_on_photo_map_id"
  end

  create_table "photo_similarities", id: :serial, force: :cascade do |t|
    t.integer "original_photo_id"
    t.integer "photo_id"
    t.integer "distance"
    t.float "search_factor"
    t.index ["original_photo_id"], name: "index_photo_similarities_on_original_photo_id"
    t.index ["photo_id"], name: "index_photo_similarities_on_photo_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "uid", limit: 255, default: ""
    t.integer "photoable_id"
    t.string "photoable_type", limit: 255
    t.string "file", limit: 255
    t.text "description"
    t.integer "view_counter", default: 0, null: false
    t.string "palette", limit: 255, default: [], array: true
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "old_rating", default: 0
    t.boolean "hidden", default: false, null: false
    t.hstore "sizes"
    t.string "state", limit: 255, default: "pending"
    t.integer "tags_count", default: 0, null: false
    t.datetime "published_at"
    t.integer "main_tag_id"
    t.integer "comments_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.hstore "legacy_info"
    t.text "version_sizes"
    t.boolean "professional", default: false
    t.string "old_file", limit: 255
    t.boolean "file_migrated", default: true, null: false
    t.string "nature", limit: 255, default: "professional", null: false
    t.text "alt"
    t.boolean "editor_choice"
    t.integer "width"
    t.integer "height"
    t.boolean "refreshed"
    t.string "color_hexes", limit: 255, default: [], array: true
    t.string "bg_color", limit: 255
    t.index ["created_at", "state", "tags_count"], name: "photos_last_photos"
    t.index ["created_at"], name: "index_photos_on_created_at"
    t.index ["file"], name: "index_photos_on_file"
    t.index ["likes_count"], name: "index_photos_on_likes_count"
    t.index ["main_tag_id"], name: "index_photos_on_main_tag_id"
    t.index ["nature"], name: "index_photos_on_nature"
    t.index ["photoable_id"], name: "index_photos_photoable_id"
    t.index ["photoable_type", "photoable_id"], name: "photos_photoable"
    t.index ["photoable_type"], name: "index_photos_photoable_type"
    t.index ["professional"], name: "index_photos_on_professional"
    t.index ["published_at"], name: "index_photos_on_published_at"
    t.index ["refreshed"], name: "index_photos_refreshed"
    t.index ["state"], name: "index_photos_on_state"
    t.index ["state"], name: "index_photos_state"
    t.index ["tags_count"], name: "index_photos_on_tags_count"
    t.index ["uid"], name: "index_photos_on_uid"
  end

  create_table "plans", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.integer "published_products_amount", default: 0
    t.boolean "system", default: false
    t.bigint "price_cents", default: 0, null: false
  end

  create_table "post_statistics", id: :serial, force: :cascade do |t|
    t.integer "post_id"
    t.integer "positive_feedback_count", default: 0
    t.integer "negative_feedback_count", default: 0
    t.string "site_version", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position_10", default: 0
    t.integer "position_30", default: 0
    t.integer "position_70", default: 0
    t.integer "position_100", default: 0
    t.integer "views", default: 0
    t.integer "teaser_views", default: 0
    t.integer "teaser_clicks", default: 0
    t.integer "viewed_to_70", default: 0
    t.integer "viewed_to_30", default: 0
    t.integer "viewed_to_10", default: 0
    t.integer "viewed_to_0", default: 0
    t.index ["post_id", "site_version"], name: "index_post_statistics_on_post_id_and_site_version", unique: true
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, default: ""
    t.text "content", default: ""
    t.string "announce", limit: 255, default: ""
    t.integer "user_id"
    t.string "state", limit: 255, default: "draft"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "likes_count", default: 0, null: false
    t.boolean "hd", default: false
    t.text "teaser_settings"
    t.text "banner", default: ""
    t.string "palette", limit: 255, default: [], array: true
    t.boolean "promo", default: false
    t.string "slug", limit: 255, default: ""
    t.integer "comments_count", default: 0, null: false
    t.text "content_text", default: ""
    t.string "teaser", limit: 255
    t.integer "view_counter", default: 0, null: false
    t.boolean "editor_choice", default: false
    t.boolean "export_for_mail", default: false
    t.integer "promo_project_id"
    t.string "external_url", limit: 255
    t.string "type", limit: 255, default: "Post"
    t.hstore "settings", default: {}
    t.boolean "teasers_migrated", default: true, null: false
    t.string "color_hexes", limit: 255, default: [], array: true
    t.boolean "content_migrated"
    t.string "social_title", limit: 255
    t.text "social_description"
    t.string "social_teaser", limit: 255
    t.integer "teaser_height"
    t.integer "teaser_width"
    t.boolean "teaser_visible", default: true, null: false
    t.integer "additional_photo_ids", default: [], array: true
    t.integer "products_discount"
    t.index ["hd"], name: "index_posts_on_hd"
    t.index ["promo_project_id"], name: "index_posts_on_promo_project_id"
    t.index ["publish_at"], name: "index_posts_on_publish_at"
    t.index ["slug"], name: "index_posts_on_slug"
    t.index ["state", "editor_choice", "publish_at", "created_at"], name: "posts_editors_main"
    t.index ["state", "publish_at", "created_at"], name: "posts_main"
    t.index ["state"], name: "index_posts_on_state"
    t.index ["title"], name: "index_posts_on_title"
    t.index ["type"], name: "posts_type"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "product_categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, default: "", null: false
    t.integer "min_sizes_count", default: 0
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "ancestry", limit: 255
    t.integer "position"
    t.json "price_ranges", default: {}
    t.integer "property_group_ids", default: [], array: true
    t.integer "property_ids", default: [], array: true
    t.integer "badge_percent", default: 1
    t.string "size_category", limit: 255
    t.index ["ancestry"], name: "index_product_categories_on_ancestry"
    t.index ["position"], name: "index_product_categories_on_position"
  end

  create_table "product_categories_product_fields", id: false, force: :cascade do |t|
    t.integer "product_category_id"
    t.integer "product_field_id"
    t.index ["product_category_id", "product_field_id"], name: "products_categories_fields", unique: true
    t.index ["product_field_id"], name: "index_product_categories_product_fields_on_product_field_id"
  end

  create_table "product_categories_property_groups", id: :serial, force: :cascade do |t|
    t.integer "product_category_id"
    t.integer "property_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_category_id", "property_group_id"], name: "pcpg_pc_id_pg_id", unique: true
    t.index ["property_group_id"], name: "pcpg_pg_id"
  end

  create_table "product_fields", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "title", limit: 255
    t.boolean "is_required", default: false
  end

  create_table "product_search_factors", id: :serial, force: :cascade do |t|
    t.string "model", limit: 255
    t.integer "model_id"
    t.string "search_value", limit: 255
  end

  create_table "product_statistic_daily_counters", id: :serial, force: :cascade do |t|
    t.integer "values", default: [0], array: true
    t.string "statistic_type", limit: 255
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_id", "statistic_type"], name: "idx_product_stat_daily_counters_on_product_id_and_stats_type", unique: true
  end

  create_table "product_statistics", id: :serial, force: :cascade do |t|
    t.integer "product_id"
    t.integer "views", default: 0
    t.integer "teaser_views", default: 0
    t.string "site_version", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "cart_count", default: 0
    t.integer "order_count", default: 0
    t.integer "collections", default: 0
    t.index ["product_id"], name: "index_product_statistics_on_product_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "title", limit: 255, default: ""
    t.text "description"
    t.integer "inner_discount"
    t.string "sku", limit: 255
    t.text "material"
    t.integer "availability_state_old", default: 0
    t.integer "state_old"
    t.datetime "state_updated_at"
    t.string "rejected_message", limit: 255, default: ""
    t.integer "product_category_id"
    t.boolean "is_banned", default: false
    t.string "external_url", limit: 500
    t.integer "country_id", default: 0
    t.decimal "weight", precision: 9, scale: 3
    t.decimal "width", precision: 6, scale: 1
    t.decimal "depth", precision: 6, scale: 1
    t.decimal "height", precision: 6, scale: 1
    t.decimal "diameter", precision: 6, scale: 1
    t.decimal "length", precision: 6, scale: 1
    t.decimal "size_big", precision: 8, scale: 2
    t.decimal "size_medium", precision: 8, scale: 2
    t.decimal "size_small", precision: 8, scale: 2
    t.string "palette", limit: 255, array: true
    t.boolean "wow", default: false
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true
    t.datetime "on_moderation_since"
    t.integer "yml_upload_id"
    t.integer "yml_category_id"
    t.integer "properties_completeness", default: 0
    t.hstore "completeness"
    t.string "state", limit: 255
    t.string "availability_state", limit: 255
    t.datetime "billing_hidden_at"
    t.integer "new_yml_category_id"
    t.string "yml_parser_id", limit: 255
    t.boolean "visible", default: false
    t.string "slug", limit: 255, default: ""
    t.decimal "rating_avg", default: "0.0"
    t.integer "rating_count", default: 0
    t.bigint "inner_price_cents", default: 0
    t.bigint "inner_old_price_cents", default: 0
    t.string "external_category_id", limit: 255
    t.string "inner_sku", limit: 255
    t.integer "stock"
    t.string "active_color_hexes", limit: 255, default: [], array: true
    t.string "recommended_color_hexes", limit: 255, default: [], array: true
    t.integer "view_counter"
    t.integer "brand_id"
    t.integer "additional_commerce_category_ids", default: [], array: true
    t.boolean "is_bestseller"
    t.boolean "is_our_choice"
    t.boolean "has_best_price"
    t.boolean "inner_hit"
    t.boolean "manual_hidden", default: false, null: false
    t.date "manual_hidden_till"
    t.boolean "rating_migrated"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["created_at", "state_old", "is_banned"], name: "products_home_products"
    t.index ["delta"], name: "index_products_on_delta"
    t.index ["is_banned"], name: "index_products_is_banned"
    t.index ["is_banned"], name: "index_products_on_is_banned"
    t.index ["new_yml_category_id"], name: "index_products_on_new_yml_category_id"
    t.index ["on_moderation_since"], name: "index_products_on_on_moderation_since"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
    t.index ["published_at"], name: "index_products_on_published_at"
    t.index ["slug"], name: "index_products_on_slug"
    t.index ["state_old"], name: "index_products_on_state_old"
    t.index ["user_id"], name: "index_products_on_user_id"
    t.index ["visible"], name: "index_products_on_visible"
    t.index ["yml_category_id", "yml_parser_id"], name: "products_import_search"
    t.index ["yml_category_id"], name: "index_products_on_yml_category_id"
    t.index ["yml_upload_id"], name: "index_products_on_yml_upload_id"
  end

  create_table "products_commerce_categories", id: :serial, force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "commerce_category_id", null: false
    t.index ["commerce_category_id"], name: "index_products_commerce_categories_on_commerce_category_id"
    t.index ["product_id"], name: "index_products_commerce_categories_on_product_id"
  end

  create_table "products_countries", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "products_properties", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "property_id"
    t.index ["product_id", "property_id"], name: "index_products_properties_on_product_id_and_property_id", unique: true
  end

  create_table "promo_projects", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title", limit: 255
    t.string "slug", limit: 255
    t.string "project_type", limit: 255
    t.string "background_list", limit: 255
    t.string "background_list_type", limit: 255
    t.string "jumbotron", limit: 255
    t.string "background", limit: 255
    t.string "background_type", limit: 255
    t.text "banner"
    t.boolean "banner_enabled", default: true
    t.string "logo", limit: 255
    t.string "link", limit: 255
    t.boolean "link_enabled", default: false
    t.text "id_google_analytics"
    t.text "additional_block"
    t.string "hashtag", limit: 255
    t.boolean "hide_sharing", default: false
    t.text "code_for_head"
    t.text "code_for_foot"
    t.string "additional_logo", limit: 255
    t.string "additional_link", limit: 255
    t.text "metrics_code"
    t.text "additional_mobile_block"
    t.text "mobile_banner"
    t.text "custom_header"
    t.text "bottom_content_block"
    t.boolean "active", default: true, null: false
    t.string "read_more_title", limit: 255
    t.index ["project_type"], name: "index_promo_projects_on_project_type"
    t.index ["slug"], name: "index_promo_projects_on_slug"
  end

  create_table "promo_teasers", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "url", limit: 255
    t.string "image", limit: 255
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promocodes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.integer "discount", default: 0
    t.integer "use_counter", default: 0
    t.boolean "active", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "purpose", limit: 255
    t.text "comment"
    t.bigint "min_order_price_cents", default: 0, null: false
    t.index ["name"], name: "index_promocodes_on_name"
  end

  create_table "properties", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "property_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.index ["property_group_id"], name: "index_properties_on_property_group_id"
  end

  create_table "property_groups", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "visible", default: false
    t.string "slug", limit: 255
    t.string "prefix", limit: 255
    t.index ["prefix"], name: "index_property_groups_on_prefix", unique: true
  end

  create_table "purchased_services", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.integer "paid_service_id"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_purchased_services_on_account_id"
    t.index ["paid_service_id"], name: "index_purchased_services_on_paid_service_id"
  end

  create_table "pushbox_mailings", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "pushbox_templates_id"
    t.bigint "pushbox_segments_id"
    t.datetime "start_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pushbox_segments_id"], name: "index_pushbox_mailings_on_pushbox_segments_id"
    t.index ["pushbox_templates_id"], name: "index_pushbox_mailings_on_pushbox_templates_id"
  end

  create_table "pushbox_segment_users", force: :cascade do |t|
    t.bigint "pushbox_segments_id"
    t.bigint "users_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pushbox_segments_id"], name: "index_pushbox_segment_users_on_pushbox_segments_id"
    t.index ["users_id"], name: "index_pushbox_segment_users_on_users_id"
  end

  create_table "pushbox_segments", force: :cascade do |t|
    t.string "title"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pushbox_templates", force: :cascade do |t|
    t.string "title", null: false
    t.text "body"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "query_modifications", id: :serial, force: :cascade do |t|
    t.string "query", limit: 255
    t.hstore "filters"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quiz_questions", id: :serial, force: :cascade do |t|
    t.integer "quiz_id"
    t.integer "number"
    t.string "title", limit: 255
    t.text "description"
    t.string "logo", limit: 255
    t.string "option_a", limit: 255, null: false
    t.string "option_b", limit: 255, null: false
    t.string "option_c", limit: 255, null: false
    t.string "option_d", limit: 255, null: false
    t.integer "correct", null: false
    t.string "result", limit: 255
    t.integer "option_a_count", default: 0, null: false
    t.integer "option_b_count", default: 0, null: false
    t.integer "option_c_count", default: 0, null: false
    t.integer "option_d_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "result_title"
    t.text "result_description"
    t.hstore "comment_for_options"
  end

  create_table "quiz_results", id: :serial, force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.string "logo", limit: 255
    t.integer "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "slug", limit: 255
    t.string "logo", limit: 255
    t.integer "participants_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "result_title"
    t.text "result_description"
    t.string "result", limit: 255
  end

  create_table "ratings", id: :serial, force: :cascade do |t|
    t.string "rateable_type", limit: 255
    t.integer "rateable_id"
    t.datetime "rated_at"
    t.integer "value", default: 0
    t.datetime "synced_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "details"
    t.decimal "per_view", default: "0.0"
    t.index ["rateable_type", "rateable_id"], name: "ratings_rateable_uniq", unique: true
  end

  create_table "reports", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "slug", limit: 255, default: ""
    t.string "title", limit: 255, default: ""
    t.text "content", default: ""
    t.string "announce", limit: 255, default: ""
    t.text "content_text", default: ""
    t.string "state", limit: 255, default: "draft"
    t.text "banner", default: ""
    t.string "palette", limit: 255, default: ""
    t.text "editor_resolution", default: ""
    t.boolean "hd", default: false
    t.boolean "promo", default: false
    t.integer "old_rating", default: 0
    t.integer "likes_count", default: 0, null: false
    t.integer "comments_count", default: 0
    t.datetime "sent_to_moderation_at"
    t.datetime "publish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "view_counter", default: 0
    t.integer "title_view_counter", default: 0
    t.integer "referral_view_counter", default: 0
    t.decimal "like_ctr", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "title_ctr", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "additional_photo_ids", default: [], array: true
  end

  create_table "requisites", id: :serial, force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "name", limit: 255, default: "", null: false
    t.string "inn", limit: 255, default: "", null: false
    t.string "kpp", limit: 255, default: "", null: false
    t.string "legal_address", limit: 255, default: "", null: false
    t.string "postal_address", limit: 255, default: "", null: false
    t.string "actual_address", limit: 255, default: "", null: false
    t.string "company_registration", limit: 255, default: "", null: false
    t.string "ogrn", limit: 255, default: "", null: false
    t.string "ceo", limit: 255, default: "", null: false
    t.string "bank", limit: 255, default: "", null: false
    t.string "bik", limit: 255, default: "", null: false
    t.string "correspondent_account", limit: 255, default: "", null: false
    t.string "account", limit: 255, default: "", null: false
    t.boolean "active", default: false
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "title", limit: 255, null: false
    t.text "description", null: false
    t.text "the_role", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rss_entries", id: :serial, force: :cascade do |t|
    t.integer "rssable_id"
    t.string "rssable_type", limit: 255
    t.integer "rss_feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rss_feed_id"], name: "index_rss_entries_on_rss_feed_id"
    t.index ["rssable_id", "rssable_type"], name: "index_rss_entries_on_rssable_id_and_rssable_type"
  end

  create_table "rss_feeds", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "slug", limit: 255
    t.string "feed_title", limit: 255
    t.boolean "active"
  end

  create_table "search_colors", id: :serial, force: :cascade do |t|
    t.string "color", limit: 255
    t.integer "tag_id"
    t.index ["color"], name: "index_search_colors_on_color"
    t.index ["tag_id"], name: "index_search_colors_on_tag_id"
  end

  create_table "shipping_methods", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "type", limit: 255
    t.string "tracking_url", limit: 255
  end

  create_table "shop_categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "shop_id"
    t.integer "yml_id"
    t.integer "yml_parent_id"
    t.integer "product_category_id"
    t.integer "offers_count", default: 0
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_category_id"], name: "index_shop_categories_on_product_category_id"
    t.index ["shop_id"], name: "index_shop_categories_on_shop_id"
  end

  create_table "shop_imports", id: :serial, force: :cascade do |t|
    t.integer "shop_id"
    t.integer "user_id"
    t.integer "progress", default: 0
    t.text "statistic"
    t.text "import_errors"
    t.boolean "is_complete", default: false
    t.integer "total"
    t.text "jobs"
    t.integer "jobs_complete", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["shop_id"], name: "index_shop_imports_on_shop_id"
    t.index ["user_id"], name: "index_shop_imports_on_user_id"
  end

  create_table "shop_optional_fields", id: false, force: :cascade do |t|
    t.integer "shop_id"
    t.integer "product_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["product_field_id"], name: "index_shop_optional_fields_on_product_field_id"
    t.index ["shop_id"], name: "index_shop_optional_fields_on_shop_id"
  end

  create_table "shopping_cart_items", id: :serial, force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type", limit: 255
    t.integer "quantity"
    t.integer "item_id"
    t.bigint "price_cents", default: 0, null: false
    t.string "price_currency", limit: 255, default: "RUB", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopping_carts", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "promocode_id"
    t.index ["user_id"], name: "index_shopping_carts_user_id"
  end

  create_table "shops", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "url", limit: 255
    t.string "yml_url", limit: 255
    t.integer "user_id"
    t.datetime "yml_updated_at"
    t.string "company", limit: 255
    t.string "yml_file", limit: 255
    t.boolean "sync", default: false
    t.datetime "synced_at"
    t.string "import_yml_job_id", limit: 255
    t.string "load_offers_job_id", limit: 255
    t.boolean "format_products_title", default: false
    t.string "sync_offers_job_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_shops_on_user_id"
  end

  create_table "short_urls", id: :serial, force: :cascade do |t|
    t.string "source_url", limit: 255
    t.string "digest", limit: 255
    t.string "url_type", limit: 255
    t.index ["digest"], name: "index_short_urls_on_digest", unique: true
    t.index ["source_url"], name: "index_short_urls_on_source_url"
  end

  create_table "similar_product_categories", id: :serial, force: :cascade do |t|
    t.integer "product_category_id", null: false
    t.integer "similar_product_category_id", null: false
    t.integer "position"
  end

  create_table "starius_rating_values", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "rateable_id"
    t.string "rateable_type", limit: 255
    t.string "subject", limit: 255
    t.integer "value"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_starius_rating_values_on_rateable_id_and_rateable_type"
  end

  create_table "stock_items", id: :serial, force: :cascade do |t|
    t.string "product_title", limit: 255
    t.string "product_sku", limit: 255
    t.decimal "volume"
    t.integer "order_id"
    t.integer "vendor_price_cents", default: 0, null: false
    t.string "stock", limit: 255
    t.datetime "arrived_at"
    t.integer "order_item_id"
    t.integer "supplier_id"
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", limit: 255
    t.datetime "state_changed_at"
    t.integer "requisite_id"
    t.index ["order_id"], name: "index_stock_items_on_order_id"
    t.index ["order_item_id"], name: "index_stock_items_on_order_item_id"
    t.index ["product_sku"], name: "index_stock_items_on_product_sku"
    t.index ["product_title"], name: "index_stock_items_on_product_title"
    t.index ["requisite_id"], name: "index_stock_items_on_requisite_id"
    t.index ["supplier_id"], name: "index_stock_items_on_supplier_id"
  end

  create_table "stocks", id: :serial, force: :cascade do |t|
    t.text "address"
    t.string "phone", limit: 255
    t.string "contact_name", limit: 255
    t.string "subway_station", limit: 255
    t.string "working_hours", limit: 255
    t.text "comment"
    t.integer "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state", limit: 255
    t.index ["company_id"], name: "index_stocks_on_company_id"
  end

  create_table "subjects", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "description"
    t.string "sponsor_logo", limit: 255
    t.integer "position"
    t.boolean "active", default: false, null: false
    t.integer "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tag_id"], name: "index_subjects_on_tag_id"
  end

  create_table "suppliers", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.text "additional_info"
    t.string "partner_order_email", limit: 255
    t.string "slug", limit: 255
    t.string "manager_phone", array: true
    t.string "phone", limit: 255
    t.string "manager_name", limit: 255
    t.string "site", limit: 255
    t.string "name", limit: 255
    t.string "upload_type", limit: 255
    t.integer "delivery_days_for_preorder_products"
    t.boolean "activated"
    t.boolean "deleted"
    t.boolean "hide_brand"
    t.integer "deferred_payment_period", default: 0
    t.integer "marginality"
    t.integer "vendor_discount"
    t.boolean "hide_preorder"
    t.text "description"
    t.text "delivery"
    t.integer "city_id"
    t.integer "country_id"
    t.string "company_name", limit: 255
    t.string "working_time_zone", limit: 255
    t.time "working_time_start"
    t.time "working_time_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "disable_preorder_downgrade", default: false, null: false
  end

  create_table "tag_categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.boolean "main", default: false
    t.boolean "closed", default: false
    t.integer "main_tags_ids", default: [], array: true
    t.boolean "assigns_posts", default: false
    t.boolean "assigns_reports", default: false
    t.boolean "assigns_photos", default: false
    t.boolean "assigns_products", default: false
    t.boolean "hardcoded", default: false
    t.integer "position", default: 0
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.boolean "show_in_post_teaser", default: false
    t.boolean "use_for_post_similars", default: false
    t.index ["slug"], name: "index_tag_categories_on_slug"
    t.index ["title"], name: "index_tag_categories_on_title"
  end

  create_table "tag_photos", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "image", limit: 255
  end

  create_table "tag_renamings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "old_tag_id"
    t.string "old_slug", limit: 255
    t.string "slug", limit: 255
    t.text "source"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type", limit: 255
    t.integer "tagger_id"
    t.string "tagger_type", limit: 255
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_id"], name: "index_taggings_taggable_id"
    t.index ["taggable_type", "tag_id"], name: "index_taggings_on_taggable_type_and_tag_id"
    t.index ["taggable_type", "taggable_id", "tag_id"], name: "taggings_unique", unique: true
    t.index ["taggable_type"], name: "index_taggings_taggable_type"
    t.index ["taggable_type"], name: "taggings_taggable_type"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "tag_category_id"
    t.string "slug", limit: 255
    t.text "description"
    t.string "meta_keywords", limit: 255
    t.text "meta_description"
    t.string "meta_title", limit: 255
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.integer "hardcoded_tag_category_id"
    t.string "legacy_url", limit: 255
    t.boolean "use_submenu", default: false
    t.boolean "published", default: true
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "migrated_at"
    t.string "google_analytics_id", limit: 255
    t.index ["legacy_url"], name: "index_tags_on_legacy_url"
    t.index ["name"], name: "index_tags_on_name"
    t.index ["position"], name: "index_tags_on_position"
    t.index ["published"], name: "index_tags_on_published"
    t.index ["slug"], name: "index_tags_on_slug"
    t.index ["use_submenu"], name: "index_tags_on_use_submenu"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, default: "", null: false
    t.text "content", default: "", null: false
    t.string "topic_type", limit: 255, default: "text"
    t.integer "forum_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_activity_at"
    t.boolean "hidden", default: false
    t.text "content_text", default: ""
    t.integer "view_counter", default: 0
    t.integer "old_rating", default: 0
    t.integer "comments_count", default: 0, null: false
  end

  create_table "transfers", id: :serial, force: :cascade do |t|
    t.integer "sender_id"
    t.string "sender_type", limit: 255
    t.integer "receiver_id"
    t.string "receiver_type", limit: 255
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["receiver_type", "receiver_id"], name: "index_transfers_on_receiver_type_and_receiver_id"
    t.index ["sender_type", "sender_id"], name: "index_transfers_on_sender_type_and_sender_id"
  end

  create_table "uploads", id: :serial, force: :cascade do |t|
    t.string "file", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "promo_project_id"
    t.index ["promo_project_id"], name: "index_uploads_on_promo_project_id"
  end

  create_table "urlchecks", id: :serial, force: :cascade do |t|
    t.string "url", limit: 255
    t.integer "response_code"
    t.string "error_class", limit: 255
    t.string "error_message", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["url"], name: "index_urlchecks_on_url", unique: true
  end

  create_table "user_favorite_products", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "synched", default: false, null: false
    t.index ["product_id"], name: "index_user_favorite_products_on_product_id"
    t.index ["user_id", "product_id"], name: "index_user_favorite_products_on_user_id_and_product_id", unique: true
  end

  create_table "user_professions", id: :serial, force: :cascade do |t|
    t.text "name", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255, default: "", null: false
    t.integer "tag_id"
    t.string "plural", limit: 255
    t.integer "position"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.integer "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "likes_count", default: 0, null: false
    t.hstore "profile"
    t.string "avatar", limit: 255
    t.date "birthday"
    t.boolean "gender", default: false
    t.boolean "show_email", default: false
    t.integer "user_profession_id"
    t.integer "city_id"
    t.integer "country_id"
    t.integer "company_type_id"
    t.string "company_name", limit: 255
    t.string "register_through", limit: 255
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "user_bg", limit: 255
    t.string "facebook_uid", limit: 255, default: ""
    t.string "vkontakte_uid", limit: 255, default: ""
    t.string "twitter_uid", limit: 255, default: ""
    t.hstore "legacy_info"
    t.boolean "gradient", default: true
    t.text "delivery"
    t.integer "portfolios_count", default: 0, null: false
    t.boolean "receive_notifications", default: true
    t.string "slug", limit: 255
    t.string "upload_type", limit: 255
    t.hstore "product_settings"
    t.boolean "show_fb_like_block", default: true
    t.string "full_terms_of_delivery", limit: 255
    t.integer "filled_portfolios_count", default: 0
    t.integer "import_step", default: 0
    t.integer "avatar_id"
    t.boolean "avatar_migrated", default: true, null: false
    t.boolean "user_bg_migrated", default: true, null: false
    t.string "old_avatar", limit: 255
    t.string "old_user_bg", limit: 255
    t.boolean "deleted", default: false, null: false
    t.string "authentication_token", limit: 20
    t.string "manager_name", limit: 255
    t.string "manager_phone", limit: 255
    t.datetime "deleted_at"
    t.hstore "utm_settings"
    t.boolean "keep_utm_params", default: false
    t.string "working_time_zone", limit: 255
    t.time "working_time_start"
    t.time "working_time_end"
    t.boolean "activated", default: false
    t.string "partner_order_email", limit: 255
    t.json "history"
    t.datetime "confirmed_at"
    t.string "email_auth_token", limit: 20
    t.string "type", limit: 255, default: "User"
    t.string "site", limit: 255
    t.integer "deferred_payment_period", default: 0
    t.integer "marginality"
    t.boolean "hide_preorder", default: false
    t.string "registration_device_type", limit: 255
    t.integer "delivery_days_for_preorder_products"
    t.decimal "rating_avg", default: "0.0"
    t.integer "rating_count", default: 0
    t.boolean "hide_brand", default: false
    t.string "role_name", limit: 255
    t.text "additional_info"
    t.float "vendor_discount"
    t.boolean "email_notification", default: true, null: false
    t.string "registration_source_type", limit: 255
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["avatar"], name: "index_users_on_avatar"
    t.index ["birthday"], name: "index_users_on_birthday"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["company_name"], name: "index_users_on_company_name"
    t.index ["company_type_id"], name: "index_users_on_company_type_id"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["gender"], name: "index_users_on_gender"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["portfolios_count"], name: "index_users_on_portfolios_count"
    t.index ["register_through"], name: "index_users_on_register_through"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["show_email"], name: "index_users_on_show_email"
    t.index ["slug"], name: "index_users_on_slug"
    t.index ["type"], name: "index_users_on_type"
    t.index ["user_bg"], name: "index_users_on_user_bg"
    t.index ["user_profession_id"], name: "index_users_on_user_profession_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.text "reason"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "count", default: 0
    t.string "question_id", limit: 255
    t.string "option_id", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "webhooks", id: :serial, force: :cascade do |t|
    t.string "kind", limit: 255
    t.string "token", limit: 255
    t.hstore "fields"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "webhookable_id"
    t.string "webhookable_type", limit: 255
  end

  create_table "yml_categories", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "products_count", default: 0
    t.string "yml_parser_id", limit: 255
    t.text "yml_products_old", default: [], array: true
    t.integer "yml_upload_id"
    t.integer "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "yml_products_count", default: 0
    t.boolean "deleted", default: false
    t.datetime "deleted_at"
    t.integer "synced_products_count", default: 0
    t.integer "total_products_count", default: 0
    t.index ["product_category_id"], name: "index_yml_categories_on_product_category_id"
    t.index ["title", "yml_upload_id"], name: "index_yml_categories_on_title_and_yml_upload_id"
    t.index ["yml_parser_id"], name: "index_yml_categories_on_yml_parser_id"
    t.index ["yml_upload_id"], name: "index_yml_categories_on_yml_upload_id"
  end

  create_table "yml_imports", id: :serial, force: :cascade do |t|
    t.integer "yml_upload_id"
    t.string "state", limit: 255
    t.datetime "start_at"
    t.datetime "finish_at"
    t.integer "products_to_process_count", default: 0
    t.integer "products_processed_count", default: 0
    t.integer "products_failed_count", default: 0
    t.integer "products_created_count", default: 0
    t.integer "products_updated_count", default: 0
    t.integer "products_removed_count", default: 0
    t.integer "products_sent_to_moderation_count", default: 0
    t.integer "photos_imported_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "products_sent_to_draft_count", default: 0
    t.text "categories_diff"
    t.text "products_diff"
    t.string "encoding", limit: 255
    t.string "comment", limit: 255
    t.boolean "dtd_valid", default: true
    t.hstore "status"
    t.string "kind", limit: 255
  end

  create_table "yml_products", id: :serial, force: :cascade do |t|
    t.integer "yml_upload_id"
    t.integer "yml_category_id"
    t.string "external_id", limit: 255
    t.text "data"
    t.index ["yml_upload_id", "external_id"], name: "index_yml_products_on_yml_upload_id_and_external_id", unique: true
  end

  create_table "yml_uploads", id: :serial, force: :cascade do |t|
    t.string "sync_type", limit: 255, default: "daily"
    t.string "link_yml", limit: 255
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "synced_at"
    t.string "import_categories_job_id", limit: 255
    t.string "import_products_job_id", limit: 255
    t.string "content_md5", limit: 32
    t.string "source_type", limit: 255
    t.index ["user_id", "link_yml"], name: "index_yml_uploads_on_user_id_and_link_yml", unique: true
    t.index ["user_id"], name: "index_yml_uploads_on_user_id"
  end

  add_foreign_key "pushbox_mailings", "pushbox_segments", column: "pushbox_segments_id"
  add_foreign_key "pushbox_mailings", "pushbox_templates", column: "pushbox_templates_id"
  add_foreign_key "pushbox_segment_users", "pushbox_segments", column: "pushbox_segments_id"
  add_foreign_key "pushbox_segment_users", "users", column: "users_id"
end
