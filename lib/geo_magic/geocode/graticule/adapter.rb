require 'graticule'

module GeoMagic
  module Geocode
    class GraticuleAdapter < BaseAdapter
      def initialize services = :google, env = :default
        super      
      end

      def instance
        @geo_coder ||= create_graticule_service
        self
      end

      def create_graticule_service key_name = nil
        api_key = get_key(key_name || service_name)
        gs_service.new api_key
      end
  
      def geocode location_str
        geo_coder.locate location_str
      end 
    
      def gs_service
        ::Graticule.service(service_name)
      end   
    end
  end 
end
