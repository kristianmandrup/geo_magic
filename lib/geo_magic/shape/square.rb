require 'geo_magic/shape'

module GeoMagic
  class Square < Rectangle
    attr_reader :distance

    def initialize point, size
      raise ArgumentError, "First argument must be a GeoMagic::Point" if !point.kind_of?(GeoMagic::Point)
      raise ArgumentError, "Second argument must be a GeoMagic::Distance or a GeoMagic::Vector" if !size.any_kind_of?(GeoMagic::Distance, GeoMagic::Vector)
      @point_a = point
          
      if size.kind_of?(GeoMagic::Distance)
        @distance = size
        calculate_b
      else
        raise "Square shape initializer must be fixed to alternatively accept a Vector arg"        
      end
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
    
    private

    def arg_check! p1, p2
      raise ArgumentError, "Rectangle must be created from two Points or a Point and a Vector" if !([p1, p2].only_kinds_of?(GeoMagic::Point) || (p1.kind_of?(GeoMagic::Point) && p2.kind_of?(GeoMagic::Vector))
    end    
  end
end