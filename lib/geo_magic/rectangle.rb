module GeoMagic
  class Rectangle
    attr_accessor :top_left_point, :bottom_right_point
    
    def initialize point_a, point_b
      @top_left_point     = GeoMagic::Point.new left_lat(point_a, point_b), bot_long(point_a, point_b)
      @bottom_right_point = GeoMagic::Point.new right_lat(point_a, point_b), top_long(point_a, point_b)
    end

    def create_from_coords lat1, long1, lat2, long2
      self.new GeoMagic::Point.new(lat1, long1), GeoMagic::Point.new(lat2, long2)
    end 
    
    def overlaps? point
      # puts "inside_top_left?: #{point} -> #{inside_top_left?(point)}"
      # puts "inside_bottom_right?: #{point} -> #{inside_bottom_right?(point)}"
      inside_top_left?(point) && inside_bottom_right?(point)
    end

    def to_s
      "#{top_left_point} - #{bottom_right_point}"
    end
    
    protected

    def top_long point_a, point_b      
      return point_a.longitude if point_a.longitude > point_b.longitude
      point_b.longitude
    end

    def bot_long point_a, point_b      
      return point_a.longitude if point_a.longitude < point_b.longitude
      point_b.longitude
    end

    def left_lat point_a, point_b
      return point_a.latitude if point_a.latitude < point_b.latitude
      point_b.latitude
    end

    def right_lat point_a, point_b
      return point_a.latitude if point_a.latitude > point_b.latitude
      point_b.latitude
    end

    
    def inside_top_left? point
      top_left_point.latitude < point.latitude && top_left_point.longitude < point.longitude
    end

    def inside_bottom_right? point
      bottom_right_point.latitude > point.latitude && bottom_right_point.longitude > point.longitude
    end
  end
end
  