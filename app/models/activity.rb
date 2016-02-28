class Activity < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :event_types
  has_and_belongs_to_many :users

end
