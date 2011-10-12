class CreateExTmdbMovies < ActiveRecord::Migration
  def self.up
    create_table :ex_tmdb_movies do |t|
      t.integer :tmdb_id
      t.integer :popularity
      t.boolean :translated
      t.boolean :adult
      t.string :language
      t.string :original_name
      t.string :name
      t.string :alternative_name
      t.string :movie_type
      t.string :imdb_id
      t.string :url
      t.integer :votes
      t.float :rating
      t.string :status
      t.string :tagline
      t.string :certification
      t.text :overview
      t.date :released
      t.integer :runtime
      t.integer :budget
      t.string :revenue
      t.string :homepage
      t.string :trailer
      t.integer :version
      t.timestamp :last_modified_at

      t.text :raw_data
      
      t.timestamps
    end

    add_index :ex_tmdb_movies, :tmdb_id, :unique => true

    execute "ALTER TABLE `ex_tmdb_movies` CHANGE COLUMN `raw_data` `raw_data` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ;"
  end

  def self.down
    drop_table :ex_tmdb_movies
  end
end
