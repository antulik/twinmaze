class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :tmdb_url
      t.integer :tmdb_id

      t.timestamps
    end

    add_index :companies, :tmdb_id, :unique => true
  end

  def self.down
    drop_table :studios
  end
end
