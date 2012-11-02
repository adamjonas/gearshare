class Location < ActiveRecord::Base
  attr_accessible :street1, :city, :state, :zip, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  

  def address
    "#{street1}, #{city}, #{state}, #{zip}"
  end

  def location_str_to_object(fb_location_as_a_string)
    self.city, self.state = fb_location_as_a_string.split(", ")
    self
  end

end
