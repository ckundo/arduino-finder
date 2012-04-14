class Store < ActiveRecord::Base
  geocoded_by :full_address
  validates_presence_of :name, :city, :state
  after_validation :geocode

  def full_address
    "#{self.address1}, #{self.address2}, #{self.city}, #{self.state} #{self.zip}"
  end

  def self.find_or_create_by_location!(location)
    find_by_location(location) or create_by_location!(location)
  end
end
