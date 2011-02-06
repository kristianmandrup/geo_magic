module GeoMagic
  class SquareRadius < Radius
    attr_accessor :distance
    
    def initialize center, distance
      super center
      @distance = distance
    end  

    # Factory
    def random_point_within 
      conversion = GeoDistance.radians_ratio(distance.unit)      

      max_radius_rad = dist.distance
      range = (max_radius_rad * normalize).to_i          

      dlong = (get_random_radiant(range) / normalize)
      dlat  = (get_random_radiant(range) / normalize)
  
      GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
    end    
    
    def random_points_within number
      conversion = distance.unit.radians_ratio

      max_radius_rad = distance.distance
      range = normalize max_radius_rad

      number.times.inject([]) do |res, n|
        dlong = denormalize get_random_radiant(range)
        dlat  = denormalize get_random_radiant(range)

        point = GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
        res << point
        res
      end      
    end
  end
end
