module GeoMagic 
  class PointsDistance
    attr_accessor :distance, :points

    def initialize distance, points
      raise ArgumentError, "First argument must be a GeoMagic::Distance, was #{distance}" if !distance.kind_of? GeoMagic::Distance
      # raise ArgumentError, "First argument must be a collection of GeoMagic::Point, was #{points}" if !points.
      self.distance = distance
      self.points = points
    end
    
    def near center
      points.select {|point| point.within(distance).of(center) }
    end
  end
end
    
    