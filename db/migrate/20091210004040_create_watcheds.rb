class CreateWatcheds < ActiveRecord::Migration
  def self.up
    create_table :watcheds do |t|
      t.integer :user_id
      t.integer :movie_id
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :watcheds
  end
end
