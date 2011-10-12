class CreateUserGenres < ActiveRecord::Migration
  def self.up
    create_table :user_genres do |t|
      t.integer :user_id
      t.integer :genre_id
      t.integer :movies_count
      t.float :avg_rating

      t.timestamps
    end

    add_index :user_genres, :user_id
    add_index :user_genres, :genre_id
    add_index :user_genres, [:user_id, :genre_id], :unique => true
  end

  def self.down
    drop_table :user_genres
  end
end
