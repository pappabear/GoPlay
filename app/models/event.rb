class Event < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :venue_id
  validates_presence_of :activity_id
  validates_presence_of :start_date
  validates_presence_of :start_time

  before_validation :convert_start_date, :on => [:create, :update]
  before_validation :convert_start_time, :on => [:create, :update]
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


  def convert_start_time
    if self.start_time == "" || self.start_time.nil?
      return #will fail validation so let it fall through
    end

    if !self.start_time.upcase.include? 'AM'
      if !self.start_time.upcase.include? 'PM'
        errors.add(:start_time, "Start time needs to be in a valid format, something like 8:00pm")
        return
      end
    end

    if self.start_time.include? ':'
      self.start_time = Time.parse(self.start_time).strftime("%l:%M %p")
    else
      apm = self.start_time[-2,2]
      b = self.start_time.to_i.to_s

      if b.length == 1
        time = b[0,1] + ':00'
      end

      if b.length == 2
        time = b[0,2] + ':00'
      end

      if b.length >= 3
        time = b[0,b.length-2] + ':' + b[-2,2]
      end
      self.start_time = Time.parse(time + apm).strftime("%l:%M %p")
    end

  end


  def convert_start_date
    if self.start_date_before_type_cast == ""
      # don't bother parsing, will generate error "cannot be blank."
      return
    end

    if self.start_date_before_type_cast.split('-').size == 3
      # date is already in yyyy-mm-dd format
      return
    end

    parts = self.start_date_before_type_cast.split('/')
    self.start_date = parts[2] + '-' + parts[0] + '-' + parts[1]
  end


end
