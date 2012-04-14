class Store < ActiveRecord::Base
  BROOKLYN_ZIP = { :zip => '11231' }

  NoPostalCodeError = Class.new(Exception)
  NoLocationsError = Class.new(Exception)

  geocoded_by :full_address
  validates_presence_of :name, :city, :state
  after_validation :geocode

  def full_address
    "#{self.address1}, #{self.address2}, #{self.city}, #{self.state} #{self.zip}"
  end

  def self.extract_zip_from_params!(params)
    location = params[:location] || BROOKLYN_ZIP
    location_values = location.values.join(', ')

    location_matches = Geocoder.search(location_values)    

    raise NoLocationsError if location_matches.empty?

    location_matches.first.postal_code or raise NoPostalCodeError
  end
end
