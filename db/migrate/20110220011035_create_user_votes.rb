class CreateUserVotes < ActiveRecord::Migration
  def self.up
    create_table :user_votes do |t|
      t.integer :rating
      t.integer :rating100
      t.timestamp :rating_date
      t.integer :tier
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
    add_index :user_votes,  :user_id
    add_index :user_votes,  :movie_id
    add_index :user_votes,  [:movie_id, :user_id], :unique => true
    add_index :user_votes,  :rating
  end

  def self.down
    drop_table :user_votes
  end
end
