module GeoMagic
  module Remote #:nodoc:
    module ClassMethods
      def my_ip
        response = HTTParty.get('http://freegeoip.net/json/')
        response.parsed_response['ip']
      end      

      def my_location
        create_location HTTParty.get('http://freegeoip.net/json/')
      end      

      def location_of ip
        create_location HTTParty.get("http://freegeoip.net/json/#{ip}")
      end
  
      protected

      # helper to create a Location object from the response
      def create_location response
        GeoMagic::Location.new response.parsed_response
      end
    end
  end
end