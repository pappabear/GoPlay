class CreateJoinTableUserActivity < ActiveRecord::Migration
  def change
    create_join_table :users, :activities do |t|
      # t.index [:user_id, :activity_id]
      # t.index [:activity_id, :user_id]
    end
  end
end
