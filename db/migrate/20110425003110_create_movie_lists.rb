class CreateMovieLists < ActiveRecord::Migration
  def self.up
    create_table :movie_lists do |t|
      t.string :name
      t.integer :user_id
      t.boolean :is_opened
      t.boolean :to_approve

      t.timestamps
    end

    add_index :movie_lists, :name
    add_index :movie_lists, :user_id
  end

  def self.down
    drop_table :movie_lists
  end
end
