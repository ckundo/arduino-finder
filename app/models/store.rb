class Store < ActiveRecord::Base
  has_many :products, :through => :inventory
  geocoded_by :full_address
  after_validation :geocode

  def check_availability
    
  end

  def full_address
    "#{self.address1}, #{self.address2}, #{self.city}, #{self.state} #{self.zip}"
  end
end
