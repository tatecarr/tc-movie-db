class AddImdbIdToWatched < ActiveRecord::Migration
  def self.up
    add_column :watcheds, :imdb_id, :string
  end

  def self.down
    remove_column :watcheds, :imdb_id
  end
end
