class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.boolean :is_anonymous
      t.boolean :is_admin

      t.timestamps

      t.timestamp :twins_updated_at
      
      t.timestamp :personal_ratings_started_at
      t.timestamp :personal_ratings_updated_at
      t.timestamp :identicon_updated_at
      t.timestamp :last_logon_at

      

      t.text :searches
    end

    add_index :users, :username

  end

  def self.down
    drop_table :users
  end
end
