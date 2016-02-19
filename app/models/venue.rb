class Venue < ActiveRecord::Base


  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude

  validates_presence_of :name

  after_validation :geocode_the_address, :on => [:create, :update]


  private


  def geocode_the_address

    begin
      address = GeocodedAddress.new(google_friendly_address)
    rescue Exception => e
      errors.add(:address1, "address is not geocodeable. We can't determine the latitude and longitude. Please enter a valid address. #{e.message}")
      return
    end

    self.formatted_address = address.formatted_address
    self.address1 = address.street_address
    self.city = address.city
    self.state = address.state
    self.zip = address.zip
    self.latitude = address.latitude
    self.longitude = address.longitude

  end


  def google_friendly_address
    s = [self.address1, self.city, self.state, self.zip].compact.join(', ')
    s = s.downcase.tr(" ", "+")
    return s
  end


end
