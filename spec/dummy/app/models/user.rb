class User < ActiveRecord::Base
  acts_as_gmappable :use_geoservicen => :is_from_dk?
  # geocoded_by :address
  
  attr_accessor :lat_test, :long_test, :bool_test
  
  after_initialize :set_lat_test
  
  def set_lat_test
    self.lat_test = address 
  end

  def is_from_dk?
    self.country == 'dk'
  end

  def geoservicen_address
    "#{self.address} #{self.town} #{self.zip_code}"
  end 

  def gmaps4rails_address 
    "#{self.address}, #{self.town}"
  end

end
