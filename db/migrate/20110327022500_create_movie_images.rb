class CreateMovieImages < ActiveRecord::Migration
  def self.up
    create_table :movie_images do |t|
      t.integer :movie_id
      t.string :tmdb_id
      t.string :tmdb_url
      t.string :tmdb_type
      t.string :size
      t.integer :height
      t.integer :width
      
      t.timestamps
    end

    add_index :movie_images, :movie_id
    add_index :movie_images, :tmdb_id
    add_index :movie_images, [:tmdb_id, :movie_id]
  end

  def self.down
    drop_table :movie_images
  end
end
