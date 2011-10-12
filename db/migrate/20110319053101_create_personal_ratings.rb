class CreatePersonalRatings < ActiveRecord::Migration
  def self.up
    create_table :personal_ratings, :id => false, :primary_key => [:user_id, :movie_id] do |t|
      t.integer :user_id
      t.integer :movie_id
      t.boolean :watched

      t.integer :best_rating_votes_level
      t.float :best_rating
      t.integer :best_rating_order

      t.float :l9_rating
      t.float :l8_rating
      t.float :l7_rating
      t.float :l6_rating
      t.float :l5_rating
      t.float :l4_rating
      t.float :l3_rating
      t.float :l2_rating
      t.float :l1_rating

      t.integer :l9_votes
      t.integer :l8_votes
      t.integer :l7_votes
      t.integer :l6_votes
      t.integer :l5_votes
      t.integer :l4_votes
      t.integer :l3_votes
      t.integer :l2_votes
      t.integer :l1_votes
      t.integer :total_votes

      t.timestamp :updated_at
    end

    add_index :personal_ratings, :user_id
    add_index :personal_ratings, :movie_id
    add_index :personal_ratings, [:user_id, :movie_id], :unique => true

    add_index :personal_ratings, :best_rating_votes_level
    add_index :personal_ratings, :best_rating
    add_index :personal_ratings, :best_rating_order
    add_index :personal_ratings, :total_votes

  end

  def self.down
    drop_table :personal_ratings
  end
end
