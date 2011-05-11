module GeoMagic
  module Direction
    class Vector < GeoMagic::Vector
      attr_accessor :direction, :distance
  
      def initialize direction, distance
        raise ArgumentError, "Invalid direction: #{direction}" if !valid_directions.include?(direction)
        raise ArgumentError, "First argument must be a GeoMagic::Distance, was: #{distance}" if !distance.kind_of?(GeoMagic::Distance)
        @direction  = direction
        @distance   = distance
      end
  
      def self.valid_directions
        [:north, :south, :east, :west, :NW, :NE, :SW, :SE]
      end

      def to_point_vector
        GeoMagic::PointVector.from_origin calc_point
      end

      ## move should use either + or << operator
      def apply_to arg
        raise ArgumentError, "Argument must be a GeoMagic::Point or a GeoMagic::PointVector" if !arg.any_kind_of?(GeoMagic::Vector, GeoMagic::PointVector)
        case arg
        when GeoMagic::Point
          point = arg
          v = calc_point
          point.move(v.latitude, v.longitude)
        when GeoMagic::PointVector
          pv = arg
          v = calc_point
          pv.latitude   = pv.latitude + v.longitude
          pv.longitude  = pv.longitude + v.longitude
          pv
        end
      end
    
      protected
    
      def calc_point
        va = 45
        c = distance
        a = c * 0.7071067770164218 # Math.sin(45 * Math.PI / 180);
        b = Math.sqrt((c * c) - (a * a));                  

        lat, lng = case direction
        when :north
          [0, -distance]
        when :south
          [0, distance]
        when :west
          [-distance, 0]
        when :east
          [distance, 0]
        when :NW
          [a, b]
        when :SW
          [a, -b]
        when :NE
          [-a, b]
        when :SE
          [-a, -b]
        end
        GeoMagic::Point.new lat, lng  
      end
    end
  end
end
