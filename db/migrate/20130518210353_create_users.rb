class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
