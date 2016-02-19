class Event < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :venue_id
  validates_presence_of :activity_id
  validates_presence_of :start_date
  validates_presence_of :start_time


  after_validation :geocode_the_address, :on => [:create, :update]


  belongs_to :venue
  belongs_to :activity
  belongs_to :event_type


  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude



  def geocode_the_address

    # grab the lat/lng from the venue
    self.latitude = self.venue.latitude
    self.longitude = self.venue.longitude

  end


end
