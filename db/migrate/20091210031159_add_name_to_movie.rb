class AddNameToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :name, :string
  end

  def self.down
    remove_column :movies, :name
  end
end
