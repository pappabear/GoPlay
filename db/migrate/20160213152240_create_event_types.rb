class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.integer :activity_id
      t.string :name

      t.timestamps null: false
    end
  end
end
