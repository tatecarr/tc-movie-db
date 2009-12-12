class AddAttributesToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :imdb_id, :string
    add_column :movies, :released, :datetime
    add_column :movies, :original_img_url, :string
    add_column :movies, :thumb_img_url, :string
  end

  def self.down
    remove_column :movies, :thumb_img_url
    remove_column :movies, :original_img_url
    remove_column :movies, :released
    remove_column :movies, :imdb_id
  end
end
