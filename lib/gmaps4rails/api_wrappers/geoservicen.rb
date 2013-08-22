#encoding: utf-8
module Gmaps4rails
  
  class Geoservicen
    include BaseNetMethods
    
    attr_reader :address, :raw, :protocol
    
    def initialize(address, options = {})
      raise Gmaps4rails::GeocodeInvalidQuery, "You must provide an address" if address.empty?
      
      @address  = address
      @raw      = options[:raw]      || false
      @protocol = options[:protocol] || "http"
    end
    
    # returns an array of hashes with the following keys:
    # - lat: mandatory for acts_as_gmappable
    # - lng: mandatory for acts_as_gmappable
    # - matched_address: facultative
    # - bounds:          facultative
    # - full_data:       facultative
    def get_coordinates
      checked_geoservicen_response do
        return parsed_response if raw

        data = {}
        data[:lat] = parsed_response.first["wgs84koordinat"]["bredde"]
        data[:lng] = parsed_response.first["wgs84koordinat"]["længde"]
        data[:oest] = parsed_response.first["etrs89koordinat"]["oest"]
        data[:nord] = parsed_response.first["etrs89koordinat"]["nord"]
        data[:results] = parsed_response.first
        
        [data.with_indifferent_access]
      end
    end
    
    private
    
    def base_request
      "#{protocol}://geo.oiorest.dk/adresser.json?q=#{address}"
    end
    
    def raise_net_status
      raise Gmaps4rails::GeocodeNetStatus, "The request sent to geoservicen was invalid (not http success): #{base_request}.\nResponse was: #{response}"
    end
    
    def raise_query_error
      raise Gmaps4rails::GeocodeStatus, "The address you passed seems invalid, status was: #{parsed_response["status"]}.\nRequest was: #{base_request}"
    end
    
  end
  
end
