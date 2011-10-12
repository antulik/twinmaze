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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110515041801) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "tmdb_url"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["tmdb_id"], :name => "index_companies_on_tmdb_id", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "ex_tmdb_movies", :force => true do |t|
    t.integer  "tmdb_id"
    t.integer  "popularity"
    t.boolean  "translated"
    t.boolean  "adult"
    t.string   "language"
    t.string   "original_name"
    t.string   "name"
    t.string   "alternative_name"
    t.string   "movie_type"
    t.string   "imdb_id"
    t.string   "url"
    t.integer  "votes"
    t.float    "rating"
    t.string   "status"
    t.string   "tagline"
    t.string   "certification"
    t.text     "overview"
    t.date     "released"
    t.integer  "runtime"
    t.integer  "budget"
    t.string   "revenue"
    t.string   "homepage"
    t.string   "trailer"
    t.integer  "version"
    t.datetime "last_modified_at"
    t.text     "raw_data",         :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ex_tmdb_movies", ["tmdb_id"], :name => "index_ex_tmdb_movies_on_tmdb_id", :unique => true

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.string   "tmdb_url"
    t.integer  "tmdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["tmdb_id"], :name => "index_genres_on_tmdb_id", :unique => true

  create_table "movie_genres", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_genres", ["genre_id"], :name => "index_movie_genres_on_genre_id"
  add_index "movie_genres", ["movie_id", "genre_id"], :name => "index_movie_genres_on_movie_id_and_genre_id", :unique => true
  add_index "movie_genres", ["movie_id"], :name => "index_movie_genres_on_movie_id"

  create_table "movie_images", :force => true do |t|
    t.integer  "movie_id"
    t.string   "tmdb_id"
    t.string   "tmdb_url"
    t.string   "tmdb_type"
    t.string   "size"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_images", ["movie_id"], :name => "index_movie_images_on_movie_id"
  add_index "movie_images", ["tmdb_id", "movie_id"], :name => "index_movie_images_on_tmdb_id_and_movie_id"
  add_index "movie_images", ["tmdb_id"], :name => "index_movie_images_on_tmdb_id"

  create_table "movie_list_items", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "movie_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_list_items", ["movie_id", "movie_list_id"], :name => "index_movie_list_items_on_movie_id_and_movie_list_id", :unique => true
  add_index "movie_list_items", ["movie_id"], :name => "index_movie_list_items_on_movie_id"
  add_index "movie_list_items", ["movie_list_id"], :name => "index_movie_list_items_on_movie_list_id"

  create_table "movie_lists", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.boolean  "is_opened"
    t.boolean  "to_approve"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_lists", ["name"], :name => "index_movie_lists_on_name"
  add_index "movie_lists", ["user_id"], :name => "index_movie_lists_on_user_id"

  create_table "movie_people", :force => true do |t|
    t.integer  "movie_id"
    t.integer  "person_id"
    t.string   "job"
    t.string   "department"
    t.string   "character"
    t.integer  "order"
    t.integer  "cast_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_people", ["movie_id", "person_id"], :name => "index_movie_people_on_movie_id_and_person_id"
  add_index "movie_people", ["movie_id"], :name => "index_movie_people_on_movie_id"
  add_index "movie_people", ["person_id"], :name => "index_movie_people_on_person_id"

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.integer  "year"
    t.text     "description"
    t.text     "image_url"
    t.integer  "runtime"
    t.string   "trailer_url"
    t.string   "imdb_id"
    t.integer  "tmdb_id"
    t.integer  "votes_rating_10"
    t.integer  "votes_rating_9"
    t.integer  "votes_rating_8"
    t.integer  "votes_rating_7"
    t.integer  "votes_rating_6"
    t.integer  "votes_rating_5"
    t.integer  "votes_rating_4"
    t.integer  "votes_rating_3"
    t.integer  "votes_rating_2"
    t.integer  "votes_rating_1"
    t.integer  "votes_rating_total"
    t.float    "votes_rating"
    t.datetime "votes_rating_updated_at"
    t.float    "tmdb_rating"
    t.integer  "tmdb_votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["id"], :name => "index_movies_on_id"
  add_index "movies", ["imdb_id"], :name => "index_movies_on_imdb_id", :unique => true
  add_index "movies", ["title"], :name => "index_movies_on_title"
  add_index "movies", ["tmdb_id"], :name => "index_movies_on_tmdb_id"
  add_index "movies", ["votes_rating"], :name => "index_movies_on_votes_rating"
  add_index "movies", ["votes_rating_total"], :name => "index_movies_on_votes_rating_total"
  add_index "movies", ["year"], :name => "index_movies_on_year"

  create_table "people", :force => true do |t|
    t.integer  "popularity"
    t.integer  "tmdb_id"
    t.string   "name"
    t.string   "also_known_as"
    t.text     "biography"
    t.integer  "known_movies"
    t.date     "birthday"
    t.string   "birthplace"
    t.integer  "version"
    t.datetime "last_modified_at"
    t.string   "tmdb_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["tmdb_id"], :name => "index_people_on_tmdb_id", :unique => true

  create_table "personal_ratings", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.boolean  "watched"
    t.integer  "best_rating_votes_level"
    t.float    "best_rating"
    t.integer  "best_rating_order"
    t.float    "l9_rating"
    t.float    "l8_rating"
    t.float    "l7_rating"
    t.float    "l6_rating"
    t.float    "l5_rating"
    t.float    "l4_rating"
    t.float    "l3_rating"
    t.float    "l2_rating"
    t.float    "l1_rating"
    t.integer  "l9_votes"
    t.integer  "l8_votes"
    t.integer  "l7_votes"
    t.integer  "l6_votes"
    t.integer  "l5_votes"
    t.integer  "l4_votes"
    t.integer  "l3_votes"
    t.integer  "l2_votes"
    t.integer  "l1_votes"
    t.integer  "total_votes"
    t.datetime "updated_at"
  end

  add_index "personal_ratings", ["best_rating"], :name => "index_personal_ratings_on_best_rating"
  add_index "personal_ratings", ["best_rating_order"], :name => "index_personal_ratings_on_best_rating_order"
  add_index "personal_ratings", ["best_rating_votes_level"], :name => "index_personal_ratings_on_best_rating_votes_level"
  add_index "personal_ratings", ["movie_id"], :name => "index_personal_ratings_on_movie_id"
  add_index "personal_ratings", ["total_votes"], :name => "index_personal_ratings_on_total_votes"
  add_index "personal_ratings", ["user_id", "movie_id"], :name => "index_personal_ratings_on_user_id_and_movie_id", :unique => true
  add_index "personal_ratings", ["user_id"], :name => "index_personal_ratings_on_user_id"

  create_table "user_genres", :force => true do |t|
    t.integer  "user_id"
    t.integer  "genre_id"
    t.integer  "movies_count"
    t.float    "avg_rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_genres", ["genre_id"], :name => "index_user_genres_on_genre_id"
  add_index "user_genres", ["user_id", "genre_id"], :name => "index_user_genres_on_user_id_and_genre_id", :unique => true
  add_index "user_genres", ["user_id"], :name => "index_user_genres_on_user_id"

  create_table "user_twins", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "twin_id"
    t.integer  "avg_difference"
    t.float    "percent"
    t.integer  "level"
    t.integer  "movies_matched"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_twins", ["twin_id"], :name => "index_user_twins_on_twin_id"
  add_index "user_twins", ["user_id", "twin_id"], :name => "index_user_twins_on_user_id_and_twin_id", :unique => true
  add_index "user_twins", ["user_id"], :name => "index_user_twins_on_user_id"

  create_table "user_votes", :force => true do |t|
    t.integer  "rating"
    t.integer  "rating100"
    t.datetime "rating_date"
    t.integer  "tier"
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_votes", ["movie_id", "user_id"], :name => "index_user_votes_on_movie_id_and_user_id", :unique => true
  add_index "user_votes", ["movie_id"], :name => "index_user_votes_on_movie_id"
  add_index "user_votes", ["rating"], :name => "index_user_votes_on_rating"
  add_index "user_votes", ["user_id"], :name => "index_user_votes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "is_anonymous"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "twins_updated_at"
    t.datetime "personal_ratings_started_at"
    t.datetime "personal_ratings_updated_at"
    t.datetime "identicon_updated_at"
    t.datetime "last_logon_at"
    t.text     "searches"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
