class RemoveMovieIdFromWatched < ActiveRecord::Migration
  def self.up
    remove_column :watcheds, :movie_id
  end

  def self.down
    add_column :watcheds, :movie_id, :integer
  end
end
