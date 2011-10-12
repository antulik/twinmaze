class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :description
      t.text :image_url
      t.integer :runtime
      t.string :trailer_url

      t.string :imdb_id
      t.integer :tmdb_id

      t.integer :votes_rating_10
      t.integer :votes_rating_9
      t.integer :votes_rating_8
      t.integer :votes_rating_7
      t.integer :votes_rating_6
      t.integer :votes_rating_5
      t.integer :votes_rating_4
      t.integer :votes_rating_3
      t.integer :votes_rating_2
      t.integer :votes_rating_1
      
      t.integer :votes_rating_total
      t.float :votes_rating
      t.timestamp :votes_rating_updated_at

      t.float :tmdb_rating
      t.integer :tmdb_votes

      t.timestamps
    end

    add_index :movies, :id
    add_index :movies, :tmdb_id
    add_index :movies, :imdb_id, :unique => true

    add_index :movies, :title
    add_index :movies, :year
    add_index :movies, :votes_rating
    add_index :movies, :votes_rating_total
  end

  def self.down
    drop_table :movies
  end
end
