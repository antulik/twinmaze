class CreateMovieGenres < ActiveRecord::Migration
  def self.up
    create_table :movie_genres do |t|
      t.integer :movie_id
      t.integer :genre_id

      t.timestamps
    end

    add_index :movie_genres, [:movie_id, :genre_id], :unique => true
    add_index :movie_genres, :movie_id
    add_index :movie_genres, :genre_id
  end

  def self.down
    drop_table :movie_genres
  end
end
