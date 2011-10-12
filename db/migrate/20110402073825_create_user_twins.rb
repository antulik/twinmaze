class CreateUserTwins < ActiveRecord::Migration
  def self.up
    create_table :user_twins, :id => false, :primary_key => [:user_id, :twin_id]  do |t|
      t.integer :user_id
      t.integer :twin_id
      t.integer :avg_difference
      t.float :percent
      t.integer :level
      t.integer :movies_matched

      t.timestamps
    end

    add_index :user_twins, :user_id
    add_index :user_twins, :twin_id
    add_index :user_twins, [:user_id, :twin_id], :unique => true
  end

  def self.down
    drop_table :user_twins
  end
end
