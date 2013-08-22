class User < ActiveRecord::Base
  acts_as_gmappable :address => :address, :use_geoservicen => :is_from_dk? #:use_geoservicen => Proc.new { |user| user.country == 'dk' } 
  # geocoded_by :address
  
  attr_accessor :lat_test, :long_test, :bool_test
  
  after_initialize :set_lat_test
  
  def set_lat_test
    self.lat_test = address 
  end

  def is_from_dk?
    self.country == 'dk'
  end
  
end
