class Event < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :venue_id
  validates_presence_of :activity_id
  validates_presence_of :start_date
  validates_presence_of :start_time

  belongs_to :venue
  belongs_to :activity
  belongs_to :event_type

end
