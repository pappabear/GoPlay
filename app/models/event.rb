class Event < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :venue_id
  validates_presence_of :activity_id
  validates_presence_of :start_date
  validates_presence_of :start_time

  before_validation :convert_date, :on => [:create, :update]
  before_validation :ensure_geo_coords, :on => [:create, :update]


  belongs_to :venue
  belongs_to :activity
  belongs_to :event_type


  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude



  private


  def ensure_geo_coords
    v = Venue.find(self.venue.id)
    self.latitude = v.latitude
    self.longitude = v.longitude
  end


  def convert_date
    buffer = self.start_date_before_type_cast
    parts = buffer.split('/')
    self.start_date = parts[2] + '-' + parts[0] + '-' + parts[1]
  end


end
