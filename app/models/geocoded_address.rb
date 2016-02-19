class GeocodedAddress

  attr_accessor :street_address
  attr_accessor :city
  attr_accessor :state
  attr_accessor :zip
  attr_accessor :formatted_address
  attr_accessor :latitude
  attr_accessor :longitude


  # Needed for Google goecoding API work
  # HACK - mechanize is overkill, but at the time of this writing the Open::URI stack has a bug (since move to Ruby 2.2.4)
  BASE_URL = "http://maps.googleapis.com/maps/api/geocode/json?address="


  def initialize(q)

    # build the actual query to send to Google
    full_url = BASE_URL + q.downcase.tr(" ", "+")

    encoded_url = URI.escape(full_url)
    #puts 'encoded_url = ' + encoded_url
    agent = Mechanize.new
    #puts 'agent created? ' + !agent.nil?
    json = agent.get(encoded_url).body
    #puts 'json = ' + json
    result = JSON.parse json

    if !result
      throw 'Result from JSON parsing is bad.'
      return
    end

    # Examine the results
    if result["status"] == "ZERO_RESULTS"
      throw 'Zero results returned from Google geocoding service for ' + q
      return
    end

    lat = result['results'][0]['geometry']['location']['lat'].to_f
    lng = result['results'][0]['geometry']['location']['lng'].to_f

    self.formatted_address = result['results'][0]['formatted_address']
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

      self.street_address = street_number + ' ' + route
      self.city = locality
      self.state = administrative_area_level_1
      self.zip = postal_code

    end

  end


end
