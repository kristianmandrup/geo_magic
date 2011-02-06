module GeoMagic
  class RectangularRadius
    attr_accessor :center, :vector

    def initialize center, vector
      super center
      @vector = vector
    end  

    def create_from *args
      case args.size 
      when 1
        arg = args.first
        if arg.kind_of? GeoMagic::Rectangle
          rectangle = arg 
          new rectangle.point_a, rectangle.vector
        end
      when 2
        vector = args.to_vector
        new vector[0], vector
      end
    end

    def lat_distance
      vector.lat_distance
    end
      
    def long_distance
      vector.long_distance
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