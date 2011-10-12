class CreateMoviePeople < ActiveRecord::Migration
  def self.up
    create_table :movie_people do |t|
      t.integer :movie_id
      t.integer :person_id

      t.string :job
      t.string :department
      t.string :character
      t.integer :order
      t.integer :cast_id

      t.timestamps
    end

    add_index :movie_people, :movie_id
    add_index :movie_people, :person_id
    add_index :movie_people, [:movie_id, :person_id]
  end

  def self.down
    drop_table :movie_people
  end
end
