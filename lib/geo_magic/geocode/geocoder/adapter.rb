require 'geocode'
require 'geo_magic/geocode/geocoder/api'

module GeoMagic
  module Geocode 
    class GeocoderAdapter < BaseAdapter
      def initialize service_name = :google, env = :default
        super      
      end

      def instance
        @geo_coder ||= ::Geocode.new_geocoder service_name, {:google_api_key => google_key}      
        self
      end
  
      def geocode location_str
        result = geo_coder.geocode(CGI.escape(location_str)).extend API
        # p result.data['Status']
        raise GeoMagic::GeoCodeError if result.data['Status']['code'] != 200
        result
      end

      def reverse_geocode latitude, longitude
        geo_coder.reverse_geocode "#{latitude}, #{longitude}"
      end      
    end
  end
end