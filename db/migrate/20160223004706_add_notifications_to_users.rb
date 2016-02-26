class AddNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :basic_notifications_mode, :string, :default=>'none'
    add_column :users, :basic_notifications_email, :string
    add_column :users, :basic_notifications_phone_number, :string
    add_column :users, :basic_notifications_frequency, :string
    add_column :users, :urgent_notifications_mode, :string, :default=>'none'
    add_column :users, :urgent_notifications_email, :string
    add_column :users, :urgent_notifications_phone_number, :string
  end
end
