module GeoMagic
  class WithinRadius
    attr_reader :distance, :point
    
    def initialize point, distance
      self.distance = distance
      self.point = point
    end  
    
    def of? center
      circle = CircularRadius.new center, distance
      point.within? circle
    end
  end
end
