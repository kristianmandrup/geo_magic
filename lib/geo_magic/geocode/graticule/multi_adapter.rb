module GeoMagic
  module Geocode
    # The Multi geocoder will try the geocoders in order if a Graticule::AddressError
    # is raised.  You can customize this behavior by passing in a block to the Multi
    # geocoder.  For example, to try the geocoders until one returns a result with a
    # high enough precision:
    #
    #   geocoder = Graticule.service(:multi).new(geocoders) do |result|
    #     [:address, :street].include?(result.precision)
    #   end
    #
    # Geocoders will be tried in order until the block returned true for one of the results
    #
    # Use the :timeout option to specify the number of seconds to allow for each
    # geocoder before raising a Timout::Error (defaults to 10 seconds).
    #
    #   Graticule.service(:multi).new(geocoders, :timeout => 3)

    class GraticuleMultiAdapter < GraticuleAdapter
      attr_accessor :map_services, :geo_coder    
  
      def initialize services, env = :default
        super(:multi, env)
        @map_services = [services].compact.uniq.flatten
      end

      def instance options = {}, &block      
        @geo_coder ||= begin      
          if block
            gs_service.new multi_services, options do |result|
              yield
            end
          else
            gs_service.new multi_services, options do |result|
              true
            end          
          end          
        end
        self
      end

      def reverse_geocode latitude, longitude
        raise "Graticule adapter does not currently support reverse geocoding"
      end

      def geocode location_str
        geo_coder.locate location_str
      end    

      def multi_services
        map_services.map do |service_name|
          api_key = send :"#{service_name}_key"
          raise ArgumentError, "API key for service #{service_name} has not been set. Please insert key in your api keys configuration file" if api_key.blank? 
          Graticule.service(service_name.to_sym).new(api_key)
        end      
      end
    end
  end
end