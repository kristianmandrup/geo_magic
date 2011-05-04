require 'geo_magic/shape'

module GeoMagic
  class Square < Rectangle
    attr_reader :distance

    def initialize point, distance
      @point_a = point
      @distance = distance
      calculate_b
    end

    def point
      @point_a
    end

    def point= point
      @point_a = point
      calculate_b
    end

    def distance= distance
      @distance = distance
      calculate_b
    end
    
    protected 
    
    def calculate_b
      @point_b = @point_a.clone.move_diagonal distance
    end
  end
end