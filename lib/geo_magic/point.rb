require 'geo_magic/map_point'
require 'geo_magic/point/class_methods'

module GeoMagic
  class Point
    extend ClassMethods
    extend Conversion
    
    def initialize latitude, longitude
      super
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
      "(lat: #{latitude}, long: #{longitude}, dist: #{dist})"
    end    
  end
end
