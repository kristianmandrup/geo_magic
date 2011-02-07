require 'geo_magic/point/class_methods'
require 'geo_magic/point/conversion'
require 'geo_magic/point/random'

module GeoMagic
  class Point
    extend ClassMethods
    extend Conversion
    extend Random

    attr_accessor :latitude, :longitude
    
    def initialize latitude, longitude
      @latitude = latitude
      @longitude = longitude
    end

    # factory method
    def self.create_from *args
      latitude, longitude = case args.size 
      when 1
        args.first.extend(GeoMagic::Point::Conversion).to_point
      when 2
         args.extend(GeoMagic::Point::Conversion).to_points
      else
        raise "Bad argument to create a point from: #{args}"
      end
      new latitude, longitude
    end    
        
    def to_point_hash mode= :long
      case mode
      when :short
        {:lat => latitude, :long => longitude}
      else
        {:latitude => latitude, :longitude => longitude}        
      end
    end 

    def to_location
      raise "You need to configure the GeoMagic geocoder, see README for instructions" if !GeoMagic.geo_coder.configured?
      GeoMagic.geo_coder.instance.reverse_geocode latitude, longitude        
    end
    
    def to_s   
      "(lat: #{latitude}, long: #{longitude})"
    end    
  end
end
