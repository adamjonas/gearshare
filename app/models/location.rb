class Location < ActiveRecord::Base
  attr_accessible :street1, :street2, :city, :state, :zip, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  

  def address
    "#{street1}, #{street2}, #{city}, #{state}, #{zip}"
  end

end
