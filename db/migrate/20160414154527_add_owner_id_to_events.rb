class AddOwnerIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :owner_id, :integer
    remove_column :events, :created_by
  end
end
