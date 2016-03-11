class AddSubscriberInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zip, :string #, :default=>""
    add_column :users, :dob, :date
  end
end
