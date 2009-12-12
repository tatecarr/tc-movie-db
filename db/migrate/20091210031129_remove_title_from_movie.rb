class RemoveTitleFromMovie < ActiveRecord::Migration
  def self.up
    remove_column :movies, :title
  end

  def self.down
    add_column :movies, :title, :string
  end
end
