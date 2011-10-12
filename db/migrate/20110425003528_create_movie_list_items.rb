class CreateMovieListItems < ActiveRecord::Migration
  def self.up
    create_table :movie_list_items do |t|
      t.integer :movie_id
      t.integer :movie_list_id

      t.timestamps
    end

    add_index :movie_list_items, :movie_id
    add_index :movie_list_items, :movie_list_id
    add_index :movie_list_items, [:movie_id, :movie_list_id], :unique => true
  end

  def self.down
    drop_table :movie_list_items
  end
end
