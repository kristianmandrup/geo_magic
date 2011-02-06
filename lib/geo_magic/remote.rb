require 'httparty'
require 'geo_magic/point'
require 'geo_magic/location'
require 'geo_magic/remote/class_methods'

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
           
    extend ClassMethods
  end
end
