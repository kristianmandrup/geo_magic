require 'geo_magic/shape'

module GeoMagic
  class Rectangle < Shape
    attr_accessor :point_b

    def initialize point_a, point_b
      arg_check!(point_a, point_b)
      @point_a = point_a
      @point_b = point_b      
    end

    # create rectangle within radius of point
    # in this case the radius has a vertical and horizontal radius
    def create_within radius
      GeoMagic::Radius::Rectangular.create_from self
    end

    # is point within the square
    def within? point
    end    

    def vector
      Vector.new(point_a, point_b)
    end

    def vector_distance
      Vector.new(point_a, point_b).vector_distance
    end

    def point_a= point
      @point_a = point_a
      invalidate_all!
    end

    def point_a= point
      @point_b = point_b
      invalidate_all!
    end

    def invalidate_all!
      @upper_left = nil
      @lower_left = nil
      @lower_right = nil
      @upper_right = nil
    end

    def upper_left
      @upper_left ||= GeoMagic::Point.new left_lat(point_a, point_b), top_long(point_a, point_b)
    end

    def lower_left
      @lower_left ||= GeoMagic::Point.new left_lat(point_a, point_b), bot_long(point_a, point_b)
    end

    def lower_right
      @lower_right ||= GeoMagic::Point.new right_lat(point_a, point_b), bot_long(point_a, point_b)
    end

    def upper_right
      @upper_right ||= GeoMagic::Point.new right_lat(point_a, point_b), top_long(point_a, point_b)
    end

    def self.create_from_coords lat1, long1, lat2, long2
      self.new GeoMagic::Point.new(lat1, long1), GeoMagic::Point.new(lat2, long2)
    end 
    
    def overlaps? point
      inside_top_left?(point) && inside_bottom_right?(point)
    end

    def to_s mode = :normal
      return "#{lower_left} - #{upper_right}" if mode == :mongoid
      "#{top_left} - #{bottom_right}"
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
    
    private

    def arg_check! p1, p2
      raise ArgumentError, "Rectangle must be created from two Points or a Point and a Vector" if !([p1, p2].only_kinds_of?(GeoMagic::Point) || (p1.kind_of?(GeoMagic::Point) && p2.kind_of?(GeoMagic::Vector))
    end
  end
end
  