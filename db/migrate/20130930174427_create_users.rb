class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :full_name
      t.string :image_url
      t.string :location
      t.integer :facebook_uid

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
