require 'httparty'
require 'geo_magic/point'
require 'geo_magic/location'

module GeoMagic
  module Remote #:nodoc:
    # Get the remote location of the request IP using http://hostip.info

    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module HostIP
      def self.my_ip
        response = HTTParty.get('http://api.hostip.info/get_html.php')
        ip = response.split("\n")
        ip.last.gsub /IP:\s+/, ''
      end
    end
    
    module ClassMethods
      def my_ip
        response = HTTParty.get('http://freegeoip.net/json/')
        response.parsed_response['ip']
      end      

      def my_location mode = :location
        create_location HTTParty.get('http://freegeoip.net/json/')
      end      

      def location_of ip
        create_location HTTParty.get("http://freegeoip.net/json/#{ip}")
      end
      
      protected
      
      def create_location response
        GeoMagic::Location.new response.parsed_response        
      end
    end
    
    extend ClassMethods
  end
end
