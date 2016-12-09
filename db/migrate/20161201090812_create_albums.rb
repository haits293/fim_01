class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.integer :artist_id
      t.integer :user_id
      t.string :name
      t.integer :views
      t.float :avg_rates
      t.integer :album_type

      t.timestamps
    end
  end
end
