module GeoMagic
    class Vector 
      attr_accessor :p0, :p1
      
      def initialize p0, p1
        raise "Vector must be initialized with a start end ending point, was: #{p0}, #{p1}" if ![p0, p1].are_points?
        @p0 = p0
        @p1 = p1
      end
      
      def [] key
        case key
        when 0, :p0
          p0
        when 1, :p1
          p1
        else
          raise "Vector key must be either 0/1 or :p0/:p1"
        end
      end      
    end
  end
end