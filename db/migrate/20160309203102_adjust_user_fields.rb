class AdjustUserFields < ActiveRecord::Migration
  def change
    remove_column :users, :basic_notifications_email
    remove_column :users, :basic_notifications_phone_number, :string
    remove_column :users, :basic_notifications_frequency, :string
    remove_column :users, :basic_notifications_mode, :string
    remove_column :users, :urgent_notifications_mode, :string
    remove_column :users, :urgent_notifications_email, :string
    remove_column :users, :urgent_notifications_phone_number, :string
    add_column :users, :phone, :string #, :default=>""
    add_column :users, :receive_basic_notifications, :boolean, :default=>true
    add_column :users, :receive_urgent_notifications, :boolean, :default=>true
  end
end
