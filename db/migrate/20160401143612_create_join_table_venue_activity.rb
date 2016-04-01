class CreateJoinTableVenueActivity < ActiveRecord::Migration
  def change
    create_join_table :venues, :activities do |t|
      # t.index [:venue_id, :activity_id]
      # t.index [:activity_id, :venue_id]
    end
  end
end
