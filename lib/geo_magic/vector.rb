module GeoMagic
    class Vector 
      attr_accessor :p0, :p1
      
      def initialize p0, p1
        raise "Vector must be initialized with a start end ending point, was: #{p0}, #{p1}" if ![p0, p1].are_points?
        @p0 = p0
        @p1 = p1
      end

      def create_at center, vector
        new center, center.move(vector)
      end

      def length type = nil
        case type
        when nil
          GeoMagic::Distance.distance(p0, p1)
        when :latitude
          (p0.latitude - p1.latitude).abs
        when :longitude
          (p0.longitude - p1.longitude).abs
        else
          raise ArgumentError, "Bad argument for calculating lenght, valid args are: nil, :latitude or :longitude"
        end
      end

      def vector_distance
        GeoMagic::Distance::Vector.new length(:latitude), length(:longitude)
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