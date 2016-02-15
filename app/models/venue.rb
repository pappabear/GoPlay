class Venue < ActiveRecord::Base

  # Needed for Google goecoding API work
  # HACK - mechanize is overkill, but at the time of this writing the Open::URI stack has a bug (since move to Ruby 2.2.4)
  BASE_URL = "http://maps.googleapis.com/maps/api/geocode/json?address="

  before_validation :geocode_address, :on => [:create, :update]


  validates_presence_of :name
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state


  def geocode_address

    puts '========Entering Venue.geocode_address()...'

    # build the actual query to send to Google
    begin

      full_url = BASE_URL + google_friendly_address
      puts 'full_url = ' + full_url
    rescue Exception => e
      errors.add(:name, "address is not geocodeable. We can't determine the latitude and longitude. Please enter a valid address. ERROR 1, google_friendly_address is bad, #{e.message}")
      return
    end

    # Make the request to retrieve the JSON string via mechanize
    begin
      encoded_url = URI.escape(full_url)
      puts 'encoded_url = ' + encoded_url
      agent = Mechanize.new
      #puts 'agent created? ' + !agent.nil?
      json = agent.get(encoded_url).body
      puts 'json = ' + json
      result = JSON.parse json
      if !result
        throw 'Result from JSON parsing is bad.'
      end
      puts 'result parsed from response body, result = ' + result.to_s
    rescue Exception => e
      errors.add(:name, "address is not geocodeable. We can't determine the latitude and longitude. Please enter a valid address. ERROR 3,  #{e.message}")
      return
    end

    # Examine the results
    if result["status"] == "ZERO_RESULTS"
      errors.add(:name, " address is not geocodeable. We can't determine the latitude and longitude. Please enter a valid address. ZERO_RESULTS.")
      return
    end

    # Extract the latitude and longitude and return them
    lat = result['results'][0]['geometry']['location']['lat'].to_f
    lng = result['results'][0]['geometry']['location']['lng'].to_f

    self.latitude, self.longitude = lat, lng

    # Update the record with the correctly formatted address based on the geocoding data returned
    street_number = ''
    route = ''
    locality = ''
    administrative_area_level_1 = ''
    postal_code = ''

    result['results'][0]['address_components'].each do |s|

      address_component_type = s['types'][0]

      case address_component_type
        when 'street_number'
          street_number = s['long_name']
        when 'route'
          route = s['long_name']
        when 'locality'
          locality = s['long_name']
        when 'administrative_area_level_1'
          administrative_area_level_1 = s['short_name']
        when 'postal_code'
          postal_code = s['long_name']
      end

      self.address1 = street_number + ' ' + route
      self.city = locality
      self.state = administrative_area_level_1
      self.zip = postal_code

    end

  end


  def google_friendly_address
    s = [self.address1, self.city, self.state, self.zip].compact.join(', ')
    s = s.downcase.tr(" ", "+")
    return s
  end


end
