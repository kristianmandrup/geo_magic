module GeoMagic
  class CircularRadius < Radius
    attr_accessor :distance
    
    def initialize center, distance
      super center
      @distance = distance
    end  

    # Factory
    def random_point_within
      max_radius_rad = dist.distance
      range = normalize max_radius_rad

      q = rand(range) * PI_2
      r = Math.sqrt(rand(range))
      dlong = denormalize (range * r) * Math.cos(q)
      dlat = denormalize (range * r) * Math.sin(q)

      GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
    end

    def random_points_within number
      conversion = GeoMagic::Distance.radians_ratio(distance.unit)

      max_radius_rad = distance.distance
      range = normalize max_radius_rad

      max_radius_rad = distance.distance
      range = normalize max_radius_rad

      number.times.inject([]) do |res, n|
        q = rand(range) * PI_2
        r = Math.sqrt(rand(range))

        dlong = denormalize (range * r) * Math.cos(q)
        dlat  = denormalize (range * r) * Math.sin(q)

        point = GeoMagic::Point.new @center.latitude + dlat, @center.longitude + dlong
        res << point
        res
      end
    end
  end
end