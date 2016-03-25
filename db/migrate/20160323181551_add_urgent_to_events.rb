class AddUrgentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_urgent, :boolean
  end
end
