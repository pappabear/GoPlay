class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :activity_id
      t.integer :event_type_id
      t.integer :venue_id
      t.string :title
      t.string :subtitle
      t.text :description
      t.text :details
      t.string :price
      t.string :restrictions
      t.string :info_url
      t.string :registration_url
      t.date :start_date
      t.datetime :start_time
      t.date :end_date
      t.datetime :end_time
      t.integer :recurrence

      t.timestamps null: false
    end
  end
end
