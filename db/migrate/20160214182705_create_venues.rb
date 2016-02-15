class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address1
      t.string :address2, allow_null: true
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.float :longitude
      t.float :latitude

      t.timestamps null: false
    end
  end
end
