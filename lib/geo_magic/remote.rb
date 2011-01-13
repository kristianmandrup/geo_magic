require 'httparty'

module GeoMagic
  module Remote #:nodoc:
    # Get the remote location of the request IP using http://hostip.info
    
    module HostIP
      def self.my_ip
        response = HTTParty.get('http://api.hostip.info/get_html.php')
        ip = response.split("\n")
        ip.last.gsub /IP:\s+/, ''
      end
    end

    def self.my_ip
      response = HTTParty.get('http://freegeoip.net/json/')
      response.parsed_response['ip']
    end      

    def self.my_location
      response = HTTParty.get('http://freegeoip.net/json/')
      response.parsed_response
    end      

    def self.location_of ip
      response = HTTParty.get("http://freegeoip.net/json/#{ip}")
      response.parsed_response
    end
  end
end
