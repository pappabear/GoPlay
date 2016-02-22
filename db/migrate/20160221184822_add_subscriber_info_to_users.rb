class AddSubscriberInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activity_id, :integer
    add_column :users, :zip, :string
    add_column :users, :dob, :date
  end
end
