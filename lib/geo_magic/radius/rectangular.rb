module GeoMagic
  class RectangularRadius
    attr_accessor :center, :vector

    def initialize center, vector
      super center
      @vector = vector
    end  

    def horizontal_distance
      vector.horizontal_distance
    end
      
    def vertical_distance
      vector.vertical_distance
    end

    # Factory
    def random_point_within
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