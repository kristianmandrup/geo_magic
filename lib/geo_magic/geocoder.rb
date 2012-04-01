require 'geo_magic/geocode/config'
require 'active_support/inflector'

require 'geo_magic/geocode/base_adapter'
require 'geo_magic/geocode/geocoder/adapter'
require 'geo_magic/geocode/graticule/adapter'
require 'geo_magic/geocode/graticule/multi_adapter'

module GeoMagic 
  class GeoCodeError < StandardError; end;
  
  class << self      
    def geo_coder options = {:type => :geocoder, :service => :google}
      service_name = options[:service_name] || :google
      type  = options[:type] || :geocoder
      env   = options[:env]

      services = options[:services] || options[:service] || :google

      begin
        clazz = "GeoMagic::Geocode::#{type.to_s.classify}Adapter".constantize      
        clazz.new services, env
      rescue Exception => e
        raise "No GeocodeAdapter found for #{type}, error: #{e}"
      end
    end 

    def reverse_geocode latitude, longitude
      geo_coder.reverse_geocode latitude, longitude
    end
  
    def geocode location_str      
      geo_coder.geocode location_str
    end    
  end
end