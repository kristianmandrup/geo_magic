module GeoMagic
  class Point
    module ClassMethods
      def extract_point point
        case point
        when Hash
          [ point[:lat] || point[:latitude], point[:long] || point[:longitude] ]      
        when GeoMagic::Point
          [point.latitude, point.longitude]
        when GeoMagic::Location
          [point.latitude, point.longitude]
        when Array
          [point[0], point[1]]
        end 
      end  
  
      def extract_points from_point, to_point
        [extract_point(from_point), extract_point(to_point)].flatten.map(&:to_f)
      end      
    end
  end
end