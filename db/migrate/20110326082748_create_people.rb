class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.integer :popularity
      t.integer :tmdb_id
      t.integer :popularity
      t.string :name
      t.string :also_known_as
      t.text :biography
      t.integer :known_movies
      t.date :birthday
      t.string :birthplace
      t.integer :version
      t.timestamp :last_modified_at
      t.string :tmdb_url

      t.timestamps
    end

    add_index :people, :tmdb_id, :unique => true
  end

  def self.down
    drop_table :people
  end
end
