require 'geo_magic/radius'

module GeoMagic
  class MapPoint
    attr_accessor :latitude, :longitude, :dist
    
    def initialize latitude, longitude
      @latitude = latitude
      @longitude = longitude
    end  

    # factory method
    def create_from *args
      case args
      when Array
      end
    end
    
    def within(distance) 
      GeoMagic::Radius.new self, distance
    end    
  end
end