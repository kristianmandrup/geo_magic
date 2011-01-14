module GeoMagic
  class Radius
    attr_accessor :center, :distance
    
    def initialize center, distance
      @center = center
      @distance = distance
    end  

    def create_point_within 
      conversion = GeoDistance.radians_ratio(distance.unit)      

      max_radius_rad = dist.distance
      range = (max_radius_rad * normalize).to_i          

      dlong = (get_random_radiant(range) / normalize)
      dlat  = (get_random_radiant(range) / normalize)
      
      GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
    end
    
    def create_points number
      conversion = GeoDistance.radians_ratio(distance.unit)

      max_radius_rad = distance.distance
      range = (max_radius_rad * normalize).to_i

      number.times.inject([]) do |res, n|
        dlong = (get_random_radiant(range) / normalize)
        dlat  = (get_random_radiant(range) / normalize)

        point = GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
        res << point
        res
      end
    end  

    def get_random_radiant range
      class.self.get_random_radiant range
    end

    def self.get_random_radiant range
      rand(range * 2) - range
    end
    
    def normalize
      100.0
    end
  end
end