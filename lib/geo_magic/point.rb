require 'geo_magic/point/class_methods'
require 'geo_magic/point/conversion'

module GeoMagic
  class Point
    extend ClassMethods
    extend Conversion

    attr_accessor :latitude, :longitude
    
    def initialize latitude, longitude
      @latitude = latitude
      @longitude = longitude
    end

    # factory method
    def create_from *args
      @latitude, @longitude = case args.size 
      when 1
        args.first.to_point
      when 2
         args.to_points
      else
        raise "Bad argument to create a point from: #{args}"
      end
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
      GeoMagic.geocoder.instance.reverse_geocode latitude, longitude
    end
    
    def to_s   
      "(lat: #{latitude}, long: #{longitude})"
    end    
  end
end
