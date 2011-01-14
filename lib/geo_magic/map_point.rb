require 'geo_magic/radius'

module GeoMagic
  class MapPoint
    attr_accessor :latitude, :longitude, :dist
    
    def initialize latitude, longitude
      @latitude = latitude
      @longitude = longitude
    end  

    def move_within distance
      conversion = GeoDistance.radians_ratio(distance.unit)      

      max_radius_rad = dist.distance
      range = (max_radius_rad * normalize).to_i          

      dlong = (get_random_radiant(range) / normalize)
      dlat  = (get_random_radiant(range) / normalize)
      
      @latitude   += dlat
      @longitude  += dlong
    end

    def move_distance radius
      distance = radius.distance
      conversion = GeoDistance.radians_ratio(distance.unit)      

      max_radius_rad = distance.distance / conversion
      range = (max_radius_rad * normalize).to_i     

      dlong = (get_random_radiant(range) / normalize) * conversion
      dlat  = (get_random_radiant(range) / normalize) * conversion
      
      GeoMagic::Point.new dist.latitude + dlat, dist.longitude + dlong      
    end
    
    def within(distance) 
      GeoMagic::Radius.new self, distance
    end  
    
    protected
    
    def get_random_radiant(range)
      GeoMagic::Radius.get_random_radiant(range)
    end
  end
end