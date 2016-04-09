class AddOwnerIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :owner_id, :integer
  end
end
