module GeoMagic 
  class PointDistance
    attr_accessor :distance, :point

    def initialize distance, point
      raise ArgumentError, "First argument must be a GeoMagic::Distance, was #{distance}" if !distance.kind_of? GeoMagic::Distance
      raise ArgumentError, "Second argument must be a GeoMagic::Point, was #{point}" if !point.kind_of? GeoMagic::Point
      @distance = distance
      @point = point
    end

    # return whether the distance between this point and a given center is within the given distance
    def of center
      vec_dist = GeoMagic::Vector.new(point, center).distance(:meters)
      puts "vec: #{vec_dist} <= #{in_meters}"
      vec_dist <= in_meters
    end
    
    private
      
    def in_meters
      distance.to_meters      
    end 
  end
end
    
