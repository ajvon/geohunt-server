class CreateUserTracks < ActiveRecord::Migration
  def change
    create_table :user_tracks do |t|
      t.datetime :date
      t.references :user
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :user_tracks, :user_id
  end
end
