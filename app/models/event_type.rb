class EventType < ActiveRecord::Base

  belongs_to :activity

  validates_presence_of :name

end
