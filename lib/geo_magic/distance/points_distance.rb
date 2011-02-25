module GeoMagic 
  class PointsDistance
    attr_accessor :distance, :points, :mode

    def initialize distance, points, mode = :select
      raise ArgumentError, "First argument must be a GeoMagic::Distance, was #{distance}" if !distance.kind_of? GeoMagic::Distance
      # raise ArgumentError, "First argument must be a collection of GeoMagic::Point, was #{points}" if !points.
      self.distance = distance
      self.points = points
      self.mode = mode
    end
    
    def near center
      case mode
      when :select
        points.select {|point| point.within(distance).of(center) }
      else
        points.reject {|point| point.within(distance).of(center) }
      end
    end
  end
end
    
    