class CreateGenres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string :name
      t.string :tmdb_url
      t.integer :tmdb_id

      t.timestamps
    end

    add_index :genres, :tmdb_id, :unique => true
  end

  def self.down
    drop_table :genres
  end
end
