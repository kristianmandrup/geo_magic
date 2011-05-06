module GeoMagic
  class Vector  
    # The vector from the origin O = (0,0) to the point A = (2,3) is simply written as (2,3).        
    def apply_to arg
      def apply_to arg
        raise ArgumentError, "Argument must be a GeoMagic::Point or a GeoMagic::PointVector" if !arg.any_kind_of?(GeoMagic::Vector, GeoMagic::PointVector)
        case arg
        when GeoMagic::Point
        when GeoMagic::PointVector
        end
      end
    end
  end
end

require 'geo_magic/vector/point_vector'
require 'geo_magic/vector/direction_vector'