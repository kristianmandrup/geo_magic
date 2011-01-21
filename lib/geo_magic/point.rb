require 'geo_magic/map_point'

module GeoMagic
  class Point < MapPoint
    
    def initialize latitude, longitude
      super
    end
        
    def to_hash mode= :long
      case mode
      when :short
        {:lat => latitude, :long => longitude}
      else
        {:latitude => latitude, :longitude => longitude}        
      end
    end 

    def to_location
      raise "TODO: Use geocoder!"
    end
    
    def to_s   
      "(lat: #{latitude}, long: #{longitude}, dist: #{dist})"
    end
  end
end
