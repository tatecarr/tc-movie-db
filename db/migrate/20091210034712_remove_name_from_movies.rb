class RemoveNameFromMovies < ActiveRecord::Migration
  def self.up
    remove_column :movies, :name
  end

  def self.down
    add_column :movies, :name, :string
  end
end
